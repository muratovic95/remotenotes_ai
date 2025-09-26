import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecordingControlsWidget extends StatelessWidget {
  final bool isRecording;
  final bool isPaused;
  final VoidCallback onRecord;
  final VoidCallback onPause;
  final VoidCallback onStop;

  const RecordingControlsWidget({
    Key? key,
    required this.isRecording,
    required this.isPaused,
    required this.onRecord,
    required this.onPause,
    required this.onStop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Record Button
        GestureDetector(
          onTap: onRecord,
          child: Container(
            width: 25.w,
            height: 25.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isRecording
                  ? AppTheme.lightTheme.colorScheme.error
                  : AppTheme.lightTheme.colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: isRecording ? 'stop' : 'mic',
                color: Colors.white,
                size: 8.w,
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        // Control Buttons Row
        if (isRecording) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Pause/Resume Button
              GestureDetector(
                onTap: onPause,
                child: Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.lightTheme.colorScheme.secondary,
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
                      iconName: isPaused ? 'play_arrow' : 'pause',
                      color: Colors.white,
                      size: 6.w,
                    ),
                  ),
                ),
              ),
              // Stop Button
              GestureDetector(
                onTap: onStop,
                child: Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.lightTheme.colorScheme.error,
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
                      iconName: 'stop',
                      color: Colors.white,
                      size: 6.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
