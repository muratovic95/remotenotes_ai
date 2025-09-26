import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TranscriptWidget extends StatefulWidget {
  final List<Map<String, dynamic>> transcriptData;
  final Duration? currentPlaybackTime;
  final Function(Duration)? onTimestampTap;

  const TranscriptWidget({
    Key? key,
    required this.transcriptData,
    this.currentPlaybackTime,
    this.onTimestampTap,
  }) : super(key: key);

  @override
  State<TranscriptWidget> createState() => _TranscriptWidgetState();
}

class _TranscriptWidgetState extends State<TranscriptWidget> {
  final ScrollController _scrollController = ScrollController();

  String _formatTimestamp(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Color _getSpeakerColor(String speaker) {
    final colors = [
      AppTheme.lightTheme.primaryColor,
      AppTheme.successLight,
      AppTheme.warningLight,
      AppTheme.errorLight,
    ];
    return colors[speaker.hashCode % colors.length];
  }

  bool _isCurrentSegment(Map<String, dynamic> segment) {
    if (widget.currentPlaybackTime == null) return false;

    final startTime = segment['startTime'] as Duration;
    final endTime = segment['endTime'] as Duration;
    final currentTime = widget.currentPlaybackTime!;

    return currentTime >= startTime && currentTime <= endTime;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Header
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'transcribe',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Transcript',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${widget.transcriptData.length} segments',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          // Transcript content
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.all(4.w),
              itemCount: widget.transcriptData.length,
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              itemBuilder: (context, index) {
                final segment = widget.transcriptData[index];
                final isHighlighted = _isCurrentSegment(segment);

                return GestureDetector(
                  onTap: () {
                    widget.onTimestampTap
                        ?.call(segment['startTime'] as Duration);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: isHighlighted
                          ? AppTheme.lightTheme.primaryColor
                              .withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: isHighlighted
                          ? Border.all(
                              color: AppTheme.lightTheme.primaryColor
                                  .withValues(alpha: 0.3),
                              width: 1,
                            )
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Speaker and timestamp row
                        Row(
                          children: [
                            // Speaker indicator
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getSpeakerColor(
                                    segment['speaker'] as String),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              segment['speaker'] as String,
                              style: AppTheme.lightTheme.textTheme.labelMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: _getSpeakerColor(
                                    segment['speaker'] as String),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                widget.onTimestampTap
                                    ?.call(segment['startTime'] as Duration);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 0.5.h),
                                decoration: BoxDecoration(
                                  color: AppTheme.lightTheme.colorScheme
                                      .surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  _formatTimestamp(
                                      segment['startTime'] as Duration),
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Transcript text
                        Text(
                          segment['text'] as String,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            height: 1.4,
                            color: isHighlighted
                                ? AppTheme.lightTheme.colorScheme.onSurface
                                : AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
