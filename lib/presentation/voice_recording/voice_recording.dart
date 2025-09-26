import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/advanced_options_sheet.dart';
import './widgets/audio_visualizer_widget.dart';
import './widgets/recording_controls_widget.dart';
import './widgets/recording_quality_widget.dart';
import './widgets/recording_timer_widget.dart';

class VoiceRecording extends StatefulWidget {
  const VoiceRecording({Key? key}) : super(key: key);

  @override
  State<VoiceRecording> createState() => _VoiceRecordingState();
}

class _VoiceRecordingState extends State<VoiceRecording>
    with TickerProviderStateMixin {
  // Recording state
  bool _isRecording = false;
  bool _isPaused = false;
  Duration _recordingDuration = Duration.zero;
  Timer? _timer;

  // Audio recording
  final AudioRecorder _audioRecorder = AudioRecorder();
  String? _recordingPath;

  // Audio visualization
  double _audioLevel = 0.0;
  Timer? _audioLevelTimer;

  // Recording settings
  bool _noiseCancellation = true;
  String _audioQuality = 'High';
  bool _speakerIdentification = false;
  String _qualityStatus = 'Good';
  double _storageRemaining = 8.5;

  // Animation controllers
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _requestPermissions();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Microphone Permission Required'),
        content: Text('This app needs microphone access to record audio.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: Text('Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(const RecordConfig(), path: 'recording.m4a');

        setState(() {
          _isRecording = true;
          _isPaused = false;
          _recordingDuration = Duration.zero;
        });

        _startTimer();
        _startAudioLevelMonitoring();
        _pulseController.repeat(reverse: true);

        // Haptic feedback
        HapticFeedback.lightImpact();
      }
    } catch (e) {
      _showErrorDialog('Failed to start recording. Please try again.');
    }
  }

  Future<void> _pauseRecording() async {
    try {
      if (_isRecording && !_isPaused) {
        await _audioRecorder.pause();
        setState(() => _isPaused = true);
        _stopTimer();
        _stopAudioLevelMonitoring();
        _pulseController.stop();
      } else if (_isPaused) {
        await _audioRecorder.resume();
        setState(() => _isPaused = false);
        _startTimer();
        _startAudioLevelMonitoring();
        _pulseController.repeat(reverse: true);
      }

      HapticFeedback.selectionClick();
    } catch (e) {
      _showErrorDialog('Failed to pause/resume recording.');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();

      setState(() {
        _isRecording = false;
        _isPaused = false;
        _recordingPath = path;
      });

      _stopTimer();
      _stopAudioLevelMonitoring();
      _pulseController.stop();
      _pulseController.reset();

      HapticFeedback.mediumImpact();

      if (path != null) {
        _showRecordingCompleteDialog();
      }
    } catch (e) {
      _showErrorDialog('Failed to stop recording.');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration = Duration(seconds: timer.tick);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _startAudioLevelMonitoring() {
    _audioLevelTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // Simulate audio level changes
      setState(() {
        _audioLevel = 0.3 + (Random().nextDouble() * 0.7);
      });
    });
  }

  void _stopAudioLevelMonitoring() {
    _audioLevelTimer?.cancel();
    setState(() => _audioLevel = 0.0);
  }

  void _showRecordingCompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Recording Complete'),
        content: Text(
            'Your recording has been saved successfully. Duration: ${_formatDuration(_recordingDuration)}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetRecording();
            },
            child: Text('New Recording'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/meeting-notes-detail');
            },
            child: Text('Process'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetRecording() {
    setState(() {
      _recordingDuration = Duration.zero;
      _recordingPath = null;
      _audioLevel = 0.0;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _showAdvancedOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AdvancedOptionsSheet(
        noiseCancellation: _noiseCancellation,
        audioQuality: _audioQuality,
        speakerIdentification: _speakerIdentification,
        onNoiseCancellationChanged: (value) {
          setState(() => _noiseCancellation = value);
        },
        onAudioQualityChanged: (value) {
          setState(() => _audioQuality = value);
        },
        onSpeakerIdentificationChanged: (value) {
          setState(() => _speakerIdentification = value);
        },
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_isRecording) {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Stop Recording?'),
          content: Text(
              'You have an active recording. Do you want to stop and discard it?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Continue Recording'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Stop & Exit'),
            ),
          ],
        ),
      );

      if (result == true) {
        await _stopRecording();
        return true;
      }
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioLevelTimer?.cancel();
    _pulseController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              // Main content
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      // Recording Timer
                      RecordingTimerWidget(
                        recordingDuration: _recordingDuration,
                        isRecording: _isRecording,
                      ),
                      SizedBox(height: 6.h),
                      // Audio Visualizer
                      AudioVisualizerWidget(
                        isRecording: _isRecording,
                        audioLevel: _audioLevel,
                      ),
                      SizedBox(height: 6.h),
                      // Recording Controls
                      RecordingControlsWidget(
                        isRecording: _isRecording,
                        isPaused: _isPaused,
                        onRecord:
                            _isRecording ? _stopRecording : _startRecording,
                        onPause: _pauseRecording,
                        onStop: _stopRecording,
                      ),
                      SizedBox(height: 6.h),
                      // Recording Quality
                      RecordingQualityWidget(
                        qualityStatus: _qualityStatus,
                        storageRemaining: _storageRemaining,
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              ),
              // Top navigation
              Positioned(
                top: 2.h,
                left: 4.w,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.lightTheme.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'close',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 6.w,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 2.h,
                right: 4.w,
                child: GestureDetector(
                  onTap: _showAdvancedOptions,
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.lightTheme.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'settings',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 6.w,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
