import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiSummaryWidget extends StatefulWidget {
  final Map<String, dynamic> summaryData;
  final bool isEditable;
  final Function(String, String)? onContentEdit;

  const AiSummaryWidget({
    Key? key,
    required this.summaryData,
    this.isEditable = true,
    this.onContentEdit,
  }) : super(key: key);

  @override
  State<AiSummaryWidget> createState() => _AiSummaryWidgetState();
}

class _AiSummaryWidgetState extends State<AiSummaryWidget> {
  final Map<String, bool> _expandedSections = {
    'keyPoints': true,
    'decisions': true,
    'nextSteps': true,
  };

  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final keyPoints = (widget.summaryData['keyPoints'] as List).cast<String>();
    final decisions = (widget.summaryData['decisions'] as List).cast<String>();
    final nextSteps = (widget.summaryData['nextSteps'] as List).cast<String>();

    for (int i = 0; i < keyPoints.length; i++) {
      _controllers['keyPoints_$i'] = TextEditingController(text: keyPoints[i]);
    }
    for (int i = 0; i < decisions.length; i++) {
      _controllers['decisions_$i'] = TextEditingController(text: decisions[i]);
    }
    for (int i = 0; i < nextSteps.length; i++) {
      _controllers['nextSteps_$i'] = TextEditingController(text: nextSteps[i]);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildSectionHeader(String title, String sectionKey, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedSections[sectionKey] = !_expandedSections[sectionKey]!;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: icon.toString().split('.').last,
              color: AppTheme.lightTheme.primaryColor,
              size: 20,
            ),
            SizedBox(width: 2.w),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            CustomIconWidget(
              iconName: _expandedSections[sectionKey]!
                  ? 'expand_less'
                  : 'expand_more',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableItem(String text, String controllerKey,
      {bool isLast = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 1.h),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: widget.isEditable
                ? TextFormField(
                    controller: _controllers[controllerKey],
                    maxLines: null,
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    onChanged: (value) {
                      widget.onContentEdit?.call(controllerKey, value);
                    },
                  )
                : Text(
                    text,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      String title, String sectionKey, IconData icon, List<String> items) {
    return Column(
      children: [
        _buildSectionHeader(title, sectionKey, icon),
        if (_expandedSections[sectionKey]!) ...[
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return _buildEditableItem(
                  item,
                  '${sectionKey}_$index',
                  isLast: index == items.length - 1,
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyPoints = (widget.summaryData['keyPoints'] as List).cast<String>();
    final decisions = (widget.summaryData['decisions'] as List).cast<String>();
    final nextSteps = (widget.summaryData['nextSteps'] as List).cast<String>();

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
                  iconName: 'auto_awesome',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'AI Summary',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (widget.isEditable)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppTheme.successLight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Editable',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.successLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                _buildSection('Key Points', 'keyPoints',
                    Icons.lightbulb_outline, keyPoints),
                SizedBox(height: 3.h),
                _buildSection('Decisions Made', 'decisions',
                    Icons.check_circle_outline, decisions),
                SizedBox(height: 3.h),
                _buildSection(
                    'Next Steps', 'nextSteps', Icons.arrow_forward, nextSteps),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
