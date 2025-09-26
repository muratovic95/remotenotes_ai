import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/advanced_options_widget.dart';
import './widgets/api_status_widget.dart';
import './widgets/file_card_widget.dart';
import './widgets/processing_queue_widget.dart';
import './widgets/upload_progress_widget.dart';
import './widgets/upload_zone_widget.dart';

class AudioUpload extends StatefulWidget {
  const AudioUpload({Key? key}) : super(key: key);

  @override
  State<AudioUpload> createState() => _AudioUploadState();
}

class _AudioUploadState extends State<AudioUpload> {
  bool _isDragOver = false;
  bool _showAdvancedOptions = false;
  String _selectedLanguage = 'English';
  int _speakerCount = 2;
  String _meetingType = 'General Meeting';
  String _apiStatus = 'online';
  String _apiMessage = 'All systems operational';

  final List<Map<String, dynamic>> _selectedFiles = [];
  final List<Map<String, dynamic>> _uploadProgress = [];
  final List<Map<String, dynamic>> _processingQueue = [];

  // Mock data for selected files
  final List<Map<String, dynamic>> _mockFiles = [
    {
      "id": 1,
      "name": "team_standup_meeting.mp3",
      "duration": "15:32",
      "size": "23.4 MB",
      "format": "mp3",
      "uploadTime": "2025-08-26 14:26:03",
    },
    {
      "id": 2,
      "name": "client_presentation_recording.m4a",
      "duration": "45:18",
      "size": "67.8 MB",
      "format": "m4a",
      "uploadTime": "2025-08-26 14:20:15",
    },
  ];

  // Mock data for upload progress
  final List<Map<String, dynamic>> _mockProgress = [
    {
      "fileName": "quarterly_review_meeting.wav",
      "progress": 75.0,
      "isPaused": false,
      "status": "Uploading... 75% complete",
    },
    {
      "fileName": "product_demo_session.mp4",
      "progress": 45.0,
      "isPaused": true,
      "status": "Paused at 45%",
    },
  ];

  // Mock data for processing queue
  final List<Map<String, dynamic>> _mockQueue = [
    {
      "fileName": "sales_call_recording.mp3",
      "estimatedTime": "3 min",
      "status": "Processing",
    },
    {
      "fileName": "interview_session.wav",
      "estimatedTime": "5 min",
      "status": "Waiting",
    },
    {
      "fileName": "training_webinar.m4a",
      "estimatedTime": "8 min",
      "status": "Completed",
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedFiles.addAll(_mockFiles);
    _uploadProgress.addAll(_mockProgress);
    _processingQueue.addAll(_mockQueue);
  }

  Future<void> _selectFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'mp4', 'wav', 'm4a'],
        allowMultiple: true,
      );

      if (result != null) {
        for (PlatformFile file in result.files) {
          final fileSize = file.size / (1024 * 1024); // Convert to MB

          if (fileSize > 500) {
            Fluttertoast.showToast(
              msg: "File ${file.name} exceeds 500MB limit",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            continue;
          }

          final newFile = {
            "id": DateTime.now().millisecondsSinceEpoch,
            "name": file.name,
            "duration": "0:00", // Would be calculated from actual file
            "size": "${fileSize.toStringAsFixed(1)} MB",
            "format": file.extension ?? 'unknown',
            "uploadTime": DateTime.now().toString(),
          };

          setState(() {
            _selectedFiles.add(newFile);
          });
        }

        if (result.files.isNotEmpty) {
          Fluttertoast.showToast(
            msg: "${result.files.length} file(s) selected successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error selecting files. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void _removeFile(int fileId) {
    setState(() {
      _selectedFiles.removeWhere((file) => (file['id'] as int) == fileId);
    });

    Fluttertoast.showToast(
      msg: "File removed successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _pauseUpload(String fileName) {
    setState(() {
      final progressIndex = _uploadProgress.indexWhere(
        (item) => (item['fileName'] as String) == fileName,
      );
      if (progressIndex != -1) {
        _uploadProgress[progressIndex]['isPaused'] =
            !(_uploadProgress[progressIndex]['isPaused'] as bool);
        _uploadProgress[progressIndex]
            ['status'] = (_uploadProgress[progressIndex]['isPaused']
                as bool)
            ? "Paused at ${(_uploadProgress[progressIndex]['progress'] as double).toInt()}%"
            : "Uploading... ${(_uploadProgress[progressIndex]['progress'] as double).toInt()}% complete";
      }
    });
  }

  void _cancelUpload(String fileName) {
    setState(() {
      _uploadProgress
          .removeWhere((item) => (item['fileName'] as String) == fileName);
    });

    Fluttertoast.showToast(
      msg: "Upload cancelled",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _startProcessing() {
    if (_selectedFiles.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please select at least one audio file",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    // Simulate processing start
    Fluttertoast.showToast(
      msg: "Processing started for ${_selectedFiles.length} file(s)",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );

    // Navigate to processing status or dashboard
    Navigator.pushNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomIconWidget(
              iconName: 'arrow_back',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 20,
            ),
          ),
        ),
        title: Text(
          'Audio Upload',
          style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Show help dialog or navigate to help screen
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Help'),
                  content: Text(
                      'Upload your audio files for AI transcription and note generation. Supported formats: MP3, MP4, WAV, M4A.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Got it'),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(2.w),
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: 'help_outline',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Upload Zone
            UploadZoneWidget(
              onTap: _selectFiles,
              isDragOver: _isDragOver,
            ),

            SizedBox(height: 3.h),

            // API Status
            ApiStatusWidget(
              status: _apiStatus,
              message: _apiMessage,
            ),

            SizedBox(height: 3.h),

            // Advanced Options Toggle
            GestureDetector(
              onTap: () {
                setState(() {
                  _showAdvancedOptions = !_showAdvancedOptions;
                });
              },
              child: Container(
                width: 85.w,
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'tune',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        'Advanced Options',
                        style: AppTheme.lightTheme.textTheme.titleSmall,
                      ),
                    ),
                    CustomIconWidget(
                      iconName:
                          _showAdvancedOptions ? 'expand_less' : 'expand_more',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            // Advanced Options Panel
            if (_showAdvancedOptions) ...[
              SizedBox(height: 2.h),
              AdvancedOptionsWidget(
                selectedLanguage: _selectedLanguage,
                speakerCount: _speakerCount,
                meetingType: _meetingType,
                onLanguageChanged: (language) {
                  setState(() {
                    _selectedLanguage = language;
                  });
                },
                onSpeakerCountChanged: (count) {
                  setState(() {
                    _speakerCount = count;
                  });
                },
                onMeetingTypeChanged: (type) {
                  setState(() {
                    _meetingType = type;
                  });
                },
              ),
            ],

            SizedBox(height: 3.h),

            // Selected Files
            if (_selectedFiles.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Selected Files (${_selectedFiles.length})',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _selectedFiles.length,
                itemBuilder: (context, index) {
                  final file = _selectedFiles[index];
                  return FileCardWidget(
                    fileData: file,
                    onRemove: () => _removeFile(file['id'] as int),
                  );
                },
              ),
              SizedBox(height: 3.h),
            ],

            // Upload Progress
            if (_uploadProgress.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Upload Progress',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _uploadProgress.length,
                itemBuilder: (context, index) {
                  final progress = _uploadProgress[index];
                  return UploadProgressWidget(
                    progressData: progress,
                    onPause: () => _pauseUpload(progress['fileName'] as String),
                    onCancel: () =>
                        _cancelUpload(progress['fileName'] as String),
                  );
                },
              ),
              SizedBox(height: 3.h),
            ],

            // Processing Queue
            ProcessingQueueWidget(
              queueItems: _processingQueue,
            ),

            SizedBox(height: 4.h),

            // Start Processing Button
            SizedBox(
              width: 85.w,
              height: 6.h,
              child: ElevatedButton(
                onPressed: _startProcessing,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.lightTheme.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'play_arrow',
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Start Processing',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Bottom Navigation Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/voice-recording'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      side: BorderSide(
                        color: AppTheme.lightTheme.colorScheme.outline,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'mic',
                          color: AppTheme.lightTheme.primaryColor,
                          size: 18,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Record',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, '/dashboard'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      side: BorderSide(
                        color: AppTheme.lightTheme.colorScheme.outline,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'dashboard',
                          color: AppTheme.lightTheme.primaryColor,
                          size: 18,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Dashboard',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
