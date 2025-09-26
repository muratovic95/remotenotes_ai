import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_items_widget.dart';
import './widgets/ai_summary_widget.dart';
import './widgets/audio_player_widget.dart';
import './widgets/floating_toolbar_widget.dart';
import './widgets/transcript_widget.dart';

class MeetingNotesDetail extends StatefulWidget {
  const MeetingNotesDetail({Key? key}) : super(key: key);

  @override
  State<MeetingNotesDetail> createState() => _MeetingNotesDetailState();
}

class _MeetingNotesDetailState extends State<MeetingNotesDetail>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleController = TextEditingController();

  bool _isEditingTitle = false;
  Duration? _currentPlaybackTime;
  late TabController _tabController;

  // Mock data for the meeting
  final Map<String, dynamic> _meetingData = {
    "id": "meeting_001",
    "title": "Q4 Product Strategy Review",
    "date": DateTime(2025, 8, 26, 14, 0),
    "duration": const Duration(minutes: 45, seconds: 30),
    "status": "completed",
    "audioUrl": "https://example.com/meeting_audio.mp3",
    "participants": [
      "Sarah Johnson",
      "Mike Chen",
      "Alex Rodriguez",
      "Emma Wilson"
    ],
  };

  final List<Map<String, dynamic>> _transcriptData = [
    {
      "speaker": "Sarah Johnson",
      "text":
          "Good afternoon everyone. Let's start with our Q4 product strategy review. I'd like to begin by discussing our current market position and the key initiatives we need to focus on.",
      "startTime": const Duration(seconds: 5),
      "endTime": const Duration(seconds: 18),
    },
    {
      "speaker": "Mike Chen",
      "text":
          "Thanks Sarah. Based on our latest analytics, we're seeing strong user engagement with the new AI features. The transcription accuracy has improved by 23% since last quarter.",
      "startTime": const Duration(seconds: 20),
      "endTime": const Duration(seconds: 32),
    },
    {
      "speaker": "Alex Rodriguez",
      "text":
          "That's excellent progress. I think we should prioritize the mobile app optimization next. Our mobile users represent 68% of our total user base, but the experience isn't as polished as desktop.",
      "startTime": const Duration(seconds: 35),
      "endTime": const Duration(seconds: 48),
    },
    {
      "speaker": "Emma Wilson",
      "text":
          "I agree with Alex. We should also consider expanding our integration capabilities. Many users are requesting Slack and Microsoft Teams integration for seamless workflow.",
      "startTime": const Duration(seconds: 50),
      "endTime": const Duration(seconds: 62),
    },
    {
      "speaker": "Sarah Johnson",
      "text":
          "Great points everyone. Let's make mobile optimization and integrations our top priorities for Q4. We'll need to allocate resources accordingly and set clear milestones.",
      "startTime": const Duration(seconds: 65),
      "endTime": const Duration(seconds: 78),
    },
  ];

  final Map<String, dynamic> _summaryData = {
    "keyPoints": [
      "Q4 product strategy focuses on mobile optimization and integration expansion",
      "AI transcription accuracy improved by 23% since last quarter",
      "Mobile users represent 68% of total user base but need better experience",
      "Strong user engagement with new AI features across all platforms",
      "Resource allocation needed for priority initiatives",
    ],
    "decisions": [
      "Mobile app optimization will be the top priority for Q4",
      "Slack and Microsoft Teams integrations will be developed",
      "Resources will be reallocated to support mobile and integration teams",
      "Clear milestones will be established for all Q4 initiatives",
    ],
    "nextSteps": [
      "Create detailed mobile optimization roadmap by end of week",
      "Research integration requirements for Slack and Teams",
      "Schedule resource allocation meeting with engineering leads",
      "Set up weekly progress reviews for Q4 initiatives",
      "Prepare user feedback analysis for mobile experience improvements",
    ],
  };

  List<Map<String, dynamic>> _actionItems = [
    {
      "id": "action_001",
      "title":
          "Create detailed mobile optimization roadmap with timeline and resource requirements",
      "assignee": "Alex Rodriguez",
      "dueDate": DateTime(2025, 8, 30),
      "priority": "high",
      "isCompleted": false,
    },
    {
      "id": "action_002",
      "title":
          "Research Slack and Microsoft Teams integration APIs and requirements",
      "assignee": "Emma Wilson",
      "dueDate": DateTime(2025, 9, 2),
      "priority": "high",
      "isCompleted": false,
    },
    {
      "id": "action_003",
      "title":
          "Schedule resource allocation meeting with engineering team leads",
      "assignee": "Sarah Johnson",
      "dueDate": DateTime(2025, 8, 28),
      "priority": "medium",
      "isCompleted": true,
    },
    {
      "id": "action_004",
      "title":
          "Prepare user feedback analysis for mobile experience improvements",
      "assignee": "Mike Chen",
      "dueDate": DateTime(2025, 9, 5),
      "priority": "medium",
      "isCompleted": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _titleController.text = _meetingData['title'] as String;
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _titleController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    }
    return '${minutes}m ${seconds}s';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppTheme.successLight;
      case 'processing':
        return AppTheme.warningLight;
      case 'failed':
        return AppTheme.errorLight;
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }

  void _onAudioSeek(Duration position) {
    setState(() {
      _currentPlaybackTime = position;
    });
  }

  void _onTranscriptTimestampTap(Duration timestamp) {
    setState(() {
      _currentPlaybackTime = timestamp;
    });
  }

  void _onActionItemUpdate(int index, Map<String, dynamic> updatedItem) {
    setState(() {
      _actionItems[index] = updatedItem;
    });
  }

  void _addNewActionItem() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController titleController = TextEditingController();
        return AlertDialog(
          title: Text('Add Action Item'),
          content: TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Enter action item description',
            ),
            maxLines: 3,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isNotEmpty) {
                  setState(() {
                    _actionItems.add({
                      "id": "action_${DateTime.now().millisecondsSinceEpoch}",
                      "title": titleController.text.trim(),
                      "assignee": null,
                      "dueDate": null,
                      "priority": "medium",
                      "isCompleted": false,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _exportToPdf() {
    // TODO: Implement PDF export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exporting to PDF...'),
        backgroundColor: AppTheme.successLight,
      ),
    );
  }

  void _shareLink() {
    // TODO: Implement share link functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share link copied to clipboard'),
        backgroundColor: AppTheme.successLight,
      ),
    );
  }

  void _sendToIntegrations() {
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
              'Send to Integrations',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'description',
                color: AppTheme.lightTheme.primaryColor,
                size: 24,
              ),
              title: Text('Google Docs'),
              subtitle: Text('Export as document'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sending to Google Docs...')),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'task',
                color: AppTheme.successLight,
                size: 24,
              ),
              title: Text('Trello'),
              subtitle: Text('Create cards from action items'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Creating Trello cards...')),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'chat',
                color: AppTheme.warningLight,
                size: 24,
              ),
              title: Text('Slack'),
              subtitle: Text('Post summary to channel'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Posting to Slack...')),
                );
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        title: Text(
          'Meeting Details',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _shareLink,
            icon: CustomIconWidget(
              iconName: 'share',
              color: AppTheme.lightTheme.primaryColor,
              size: 24,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          // Header section
          Container(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title (editable)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditingTitle = true;
                    });
                  },
                  child: _isEditingTitle
                      ? TextFormField(
                          controller: _titleController,
                          style: AppTheme.lightTheme.textTheme.headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          autofocus: true,
                          onFieldSubmitted: (value) {
                            setState(() {
                              _isEditingTitle = false;
                              _meetingData['title'] = value;
                            });
                          },
                          onTapOutside: (event) {
                            setState(() {
                              _isEditingTitle = false;
                            });
                          },
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: Text(
                                _titleController.text,
                                style: AppTheme
                                    .lightTheme.textTheme.headlineSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            CustomIconWidget(
                              iconName: 'edit',
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                              size: 20,
                            ),
                          ],
                        ),
                ),
                SizedBox(height: 2.h),
                // Meeting info row
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'calendar_today',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      _formatDate(_meetingData['date'] as DateTime),
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                    SizedBox(width: 4.w),
                    CustomIconWidget(
                      iconName: 'schedule',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      _formatDuration(_meetingData['duration'] as Duration),
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor(_meetingData['status'] as String)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (_meetingData['status'] as String).toUpperCase(),
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              _getStatusColor(_meetingData['status'] as String),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tab bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Audio'),
                Tab(text: 'Transcript'),
                Tab(text: 'Summary'),
                Tab(text: 'Actions'),
              ],
              labelStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTheme.lightTheme.textTheme.bodyMedium,
              indicator: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              labelColor: Colors.white,
              unselectedLabelColor:
                  AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              dividerColor: Colors.transparent,
            ),
          ),
          SizedBox(height: 2.h),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Audio tab
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: AudioPlayerWidget(
                    audioUrl: _meetingData['audioUrl'] as String,
                    duration: _meetingData['duration'] as Duration,
                    onSeek: _onAudioSeek,
                    onSpeedChange: (speed) {
                      // Handle playback speed change
                    },
                  ),
                ),
                // Transcript tab
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: TranscriptWidget(
                    transcriptData: _transcriptData,
                    currentPlaybackTime: _currentPlaybackTime,
                    onTimestampTap: _onTranscriptTimestampTap,
                  ),
                ),
                // Summary tab
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: AiSummaryWidget(
                    summaryData: _summaryData,
                    isEditable: true,
                    onContentEdit: (key, value) {
                      // Handle content editing
                    },
                  ),
                ),
                // Actions tab
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ActionItemsWidget(
                    actionItems: _actionItems,
                    onItemUpdate: _onActionItemUpdate,
                    onAddItem: _addNewActionItem,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingToolbarWidget(
        onExportPdf: _exportToPdf,
        onShareLink: _shareLink,
        onSendToIntegrations: _sendToIntegrations,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
