import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class RecordingTimerWidget extends StatelessWidget {
  final Duration recordingDuration;
  final bool isRecording;

  const RecordingTimerWidget({
    Key? key,
    required this.recordingDuration,
    required this.isRecording,
  }) : super(key: key);

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: isRecording
            ? AppTheme.lightTheme.colorScheme.errorContainer
            : AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isRecording
              ? AppTheme.lightTheme.colorScheme.error
              : AppTheme.lightTheme.colorScheme.outline,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isRecording) ...[
            Container(
              width: 3.w,
              height: 3.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.lightTheme.colorScheme.error,
              ),
            ),
            SizedBox(width: 2.w),
          ],
          Text(
            _formatDuration(recordingDuration),
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isRecording
                  ? AppTheme.lightTheme.colorScheme.error
                  : AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
