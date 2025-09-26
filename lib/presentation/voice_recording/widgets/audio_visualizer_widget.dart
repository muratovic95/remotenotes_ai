import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AudioVisualizerWidget extends StatefulWidget {
  final bool isRecording;
  final double audioLevel;

  const AudioVisualizerWidget({
    Key? key,
    required this.isRecording,
    required this.audioLevel,
  }) : super(key: key);

  @override
  State<AudioVisualizerWidget> createState() => _AudioVisualizerWidgetState();
}

class _AudioVisualizerWidgetState extends State<AudioVisualizerWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.isRecording) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AudioVisualizerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording && !oldWidget.isRecording) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isRecording && oldWidget.isRecording) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 20.h,
      child: widget.isRecording
          ? AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: WaveformPainter(
                    audioLevel: widget.audioLevel,
                    pulseScale: _pulseAnimation.value,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                  size: Size(80.w, 20.h),
                );
              },
            )
          : Container(
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Audio waveform will appear here during recording',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final double audioLevel;
  final double pulseScale;
  final Color color;

  WaveformPainter({
    required this.audioLevel,
    required this.pulseScale,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final centerY = size.height / 2;
    final barWidth = size.width / 50;
    final maxHeight = size.height * 0.8;

    for (int i = 0; i < 50; i++) {
      final x = i * barWidth;
      final height = (maxHeight * audioLevel * pulseScale) *
          (0.3 +
              0.7 *
                  (i % 3 == 0
                      ? 1.0
                      : i % 2 == 0
                          ? 0.7
                          : 0.5));

      canvas.drawLine(
        Offset(x, centerY - height / 2),
        Offset(x, centerY + height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
