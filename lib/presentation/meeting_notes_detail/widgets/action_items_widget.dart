import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ActionItemsWidget extends StatefulWidget {
  final List<Map<String, dynamic>> actionItems;
  final Function(int, Map<String, dynamic>)? onItemUpdate;
  final Function()? onAddItem;

  const ActionItemsWidget({
    Key? key,
    required this.actionItems,
    this.onItemUpdate,
    this.onAddItem,
  }) : super(key: key);

  @override
  State<ActionItemsWidget> createState() => _ActionItemsWidgetState();
}

class _ActionItemsWidgetState extends State<ActionItemsWidget> {
  void _toggleItemCompletion(int index) {
    final item = Map<String, dynamic>.from(widget.actionItems[index]);
    item['isCompleted'] = !(item['isCompleted'] as bool);
    widget.onItemUpdate?.call(index, item);
  }

  void _showAssigneeDialog(int index) {
    final currentAssignee = widget.actionItems[index]['assignee'] as String?;
    final TextEditingController controller =
        TextEditingController(text: currentAssignee ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Assign To'),
        content: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter assignee name or email',
            prefixIcon: Icon(Icons.person_outline),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final item = Map<String, dynamic>.from(widget.actionItems[index]);
              item['assignee'] = controller.text.trim();
              widget.onItemUpdate?.call(index, item);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDueDatePicker(int index) async {
    final currentDueDate = widget.actionItems[index]['dueDate'] as DateTime?;

    final selectedDate = await showDatePicker(
      context: context,
      initialDate:
          currentDueDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      final item = Map<String, dynamic>.from(widget.actionItems[index]);
      item['dueDate'] = selectedDate;
      widget.onItemUpdate?.call(index, item);
    }
  }

  String _formatDueDate(DateTime? dueDate) {
    if (dueDate == null) return 'No due date';

    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;

    if (difference == 0) return 'Due today';
    if (difference == 1) return 'Due tomorrow';
    if (difference < 0) return 'Overdue';
    if (difference <= 7) return 'Due in $difference days';

    return '${dueDate.day}/${dueDate.month}/${dueDate.year}';
  }

  Color _getDueDateColor(DateTime? dueDate) {
    if (dueDate == null)
      return AppTheme.lightTheme.colorScheme.onSurfaceVariant;

    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;

    if (difference < 0) return AppTheme.errorLight;
    if (difference <= 1) return AppTheme.warningLight;
    if (difference <= 3) return AppTheme.warningLight.withValues(alpha: 0.7);

    return AppTheme.successLight;
  }

  Widget _buildActionItem(int index) {
    final item = widget.actionItems[index];
    final isCompleted = item['isCompleted'] as bool;
    final title = item['title'] as String;
    final assignee = item['assignee'] as String?;
    final dueDate = item['dueDate'] as DateTime?;
    final priority = item['priority'] as String? ?? 'medium';

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppTheme.lightTheme.colorScheme.surfaceContainerHighest
                .withValues(alpha: 0.5)
            : AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted
              ? AppTheme.successLight.withValues(alpha: 0.3)
              : AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and checkbox row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _toggleItemCompletion(index),
                child: Container(
                  width: 6.w,
                  height: 6.w,
                  margin: EdgeInsets.only(top: 0.5.h),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppTheme.successLight
                        : Colors.transparent,
                    border: Border.all(
                      color: isCompleted
                          ? AppTheme.successLight
                          : AppTheme.lightTheme.colorScheme.outline,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: isCompleted
                      ? CustomIconWidget(
                          iconName: 'check',
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted
                        ? AppTheme.lightTheme.colorScheme.onSurfaceVariant
                        : AppTheme.lightTheme.colorScheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ),
              // Priority indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: priority == 'high'
                      ? AppTheme.errorLight.withValues(alpha: 0.1)
                      : priority == 'medium'
                          ? AppTheme.warningLight.withValues(alpha: 0.1)
                          : AppTheme.successLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  priority.toUpperCase(),
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: priority == 'high'
                        ? AppTheme.errorLight
                        : priority == 'medium'
                            ? AppTheme.warningLight
                            : AppTheme.successLight,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Assignee and due date row
          Row(
            children: [
              // Assignee
              Expanded(
                child: GestureDetector(
                  onTap: () => _showAssigneeDialog(index),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: AppTheme
                          .lightTheme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'person_outline',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 16,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            assignee ?? 'Unassigned',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: assignee != null
                                  ? AppTheme.lightTheme.colorScheme.onSurface
                                  : AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              // Due date
              GestureDetector(
                onTap: () => _showDueDatePicker(index),
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
                      CustomIconWidget(
                        iconName: 'schedule',
                        color: _getDueDateColor(dueDate),
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        _formatDueDate(dueDate),
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: _getDueDateColor(dueDate),
                          fontWeight: FontWeight.w500,
                        ),
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
                  iconName: 'task_alt',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Action Items',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${widget.actionItems.where((item) => item['isCompleted'] as bool).length}/${widget.actionItems.length} completed',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
                SizedBox(width: 2.w),
                GestureDetector(
                  onTap: widget.onAddItem,
                  child: CustomIconWidget(
                    iconName: 'add',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          // Action items list
          Padding(
            padding: EdgeInsets.all(4.w),
            child: widget.actionItems.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(height: 4.h),
                        CustomIconWidget(
                          iconName: 'task_alt',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 48,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'No action items yet',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        TextButton(
                          onPressed: widget.onAddItem,
                          child: Text('Add first action item'),
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  )
                : Column(
                    children: widget.actionItems.asMap().entries.map((entry) {
                      return _buildActionItem(entry.key);
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
