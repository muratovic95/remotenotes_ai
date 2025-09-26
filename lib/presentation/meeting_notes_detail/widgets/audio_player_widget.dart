import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  final Duration duration;
  final Function(Duration)? onSeek;
  final Function(double)? onSpeedChange;

  const AudioPlayerWidget({
    Key? key,
    required this.audioUrl,
    required this.duration,
    this.onSeek,
    this.onSpeedChange,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  double _playbackSpeed = 1.0;
  final List<double> _speedOptions = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _onSeek(double value) {
    final position = Duration(
        milliseconds: (value * widget.duration.inMilliseconds).round());
    setState(() {
      _currentPosition = position;
    });
    widget.onSeek?.call(position);
  }

  void _showSpeedSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Playback Speed',
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 2.h),
            ...(_speedOptions
                .map((speed) => ListTile(
                      title: Text('${speed}x'),
                      trailing: _playbackSpeed == speed
                          ? CustomIconWidget(
                              iconName: 'check',
                              color: AppTheme.lightTheme.primaryColor,
                              size: 20,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          _playbackSpeed = speed;
                        });
                        widget.onSpeedChange?.call(speed);
                        Navigator.pop(context);
                      },
                    ))
                .toList()),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Audio controls row
          Row(
            children: [
              // Play/Pause button
              GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: _isPlaying ? 'pause' : 'play_arrow',
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              // Time display
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_currentPosition),
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _formatDuration(widget.duration),
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    // Progress slider
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3,
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 6),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 12),
                      ),
                      child: Slider(
                        value: widget.duration.inMilliseconds > 0
                            ? _currentPosition.inMilliseconds /
                                widget.duration.inMilliseconds
                            : 0.0,
                        onChanged: _onSeek,
                        activeColor: AppTheme.lightTheme.primaryColor,
                        inactiveColor: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 3.w),
              // Speed selector
              GestureDetector(
                onTap: _showSpeedSelector,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color:
                        AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${_playbackSpeed}x',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      CustomIconWidget(
                        iconName: 'keyboard_arrow_down',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
