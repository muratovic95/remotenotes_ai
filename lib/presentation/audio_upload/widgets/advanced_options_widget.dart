import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AdvancedOptionsWidget extends StatelessWidget {
  final String selectedLanguage;
  final int speakerCount;
  final String meetingType;
  final Function(String) onLanguageChanged;
  final Function(int) onSpeakerCountChanged;
  final Function(String) onMeetingTypeChanged;

  const AdvancedOptionsWidget({
    Key? key,
    required this.selectedLanguage,
    required this.speakerCount,
    required this.meetingType,
    required this.onLanguageChanged,
    required this.onSpeakerCountChanged,
    required this.onMeetingTypeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> languages = [
      'English',
      'Spanish',
      'French',
      'German',
      'Italian'
    ];
    final List<String> meetingTypes = [
      'General Meeting',
      'Sales Call',
      'Interview',
      'Training',
      'Standup'
    ];

    return Container(
      width: 85.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'settings',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Advanced Options',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),

          // Language Selection
          Text(
            'Language',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedLanguage,
                isExpanded: true,
                items: languages.map((String language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(
                      language,
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onLanguageChanged(newValue);
                  }
                },
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Speaker Count
          Text(
            'Number of Speakers',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (speakerCount > 1) {
                    onSpeakerCountChanged(speakerCount - 1);
                  }
                },
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: speakerCount > 1
                        ? AppTheme.lightTheme.primaryColor
                        : AppTheme.lightTheme.colorScheme.outline,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomIconWidget(
                    iconName: 'remove',
                    color: speakerCount > 1
                        ? Colors.white
                        : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                width: 15.w,
                height: 10.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    speakerCount.toString(),
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              GestureDetector(
                onTap: () {
                  if (speakerCount < 10) {
                    onSpeakerCountChanged(speakerCount + 1);
                  }
                },
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: speakerCount < 10
                        ? AppTheme.lightTheme.primaryColor
                        : AppTheme.lightTheme.colorScheme.outline,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomIconWidget(
                    iconName: 'add',
                    color: speakerCount < 10
                        ? Colors.white
                        : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Meeting Type
          Text(
            'Meeting Type',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: meetingType,
                isExpanded: true,
                items: meetingTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(
                      type,
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onMeetingTypeChanged(newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
