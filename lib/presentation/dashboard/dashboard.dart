import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/dashboard_header_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/meeting_card_widget.dart';
import './widgets/search_bar_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _isSearchCollapsed = false;
  String _searchQuery = '';
  List<Map<String, dynamic>> _filteredMeetings = [];
  bool _isRefreshing = false;

  // Mock data for meetings
  final List<Map<String, dynamic>> _meetings = [
    {
      "id": 1,
      "title": "Weekly Team Standup - Sprint Planning",
      "date": "Aug 26, 2025 • 10:30 AM",
      "duration": "45 min",
      "status": "completed",
      "waveform": [
        0.2,
        0.8,
        0.4,
        0.9,
        0.3,
        0.7,
        0.5,
        0.6,
        0.8,
        0.4,
        0.9,
        0.2,
        0.7,
        0.5,
        0.8,
        0.3,
        0.6,
        0.9,
        0.4,
        0.7
      ],
    },
    {
      "id": 2,
      "title": "Client Presentation - Q3 Results",
      "date": "Aug 25, 2025 • 2:15 PM",
      "duration": "1h 20min",
      "status": "transcribing",
      "waveform": [
        0.5,
        0.3,
        0.8,
        0.6,
        0.9,
        0.2,
        0.7,
        0.4,
        0.8,
        0.5,
        0.3,
        0.9,
        0.6,
        0.7,
        0.4,
        0.8,
        0.2,
        0.5,
        0.9,
        0.3
      ],
    },
    {
      "id": 3,
      "title": "Product Strategy Discussion",
      "date": "Aug 24, 2025 • 11:00 AM",
      "duration": "55 min",
      "status": "completed",
      "waveform": [
        0.7,
        0.4,
        0.9,
        0.2,
        0.6,
        0.8,
        0.3,
        0.5,
        0.9,
        0.7,
        0.4,
        0.8,
        0.2,
        0.6,
        0.5,
        0.9,
        0.3,
        0.7,
        0.8,
        0.4
      ],
    },
    {
      "id": 4,
      "title": "Budget Review Meeting",
      "date": "Aug 23, 2025 • 9:45 AM",
      "duration": "30 min",
      "status": "recorded",
      "waveform": [
        0.3,
        0.7,
        0.5,
        0.8,
        0.4,
        0.9,
        0.2,
        0.6,
        0.7,
        0.5,
        0.8,
        0.3,
        0.9,
        0.4,
        0.6,
        0.7,
        0.2,
        0.8,
        0.5,
        0.9
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _filteredMeetings = List.from(_meetings);

    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && !_isSearchCollapsed) {
        setState(() {
          _isSearchCollapsed = true;
        });
      } else if (_scrollController.offset <= 100 && _isSearchCollapsed) {
        setState(() {
          _isSearchCollapsed = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _filterMeetings(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredMeetings = List.from(_meetings);
      } else {
        _filteredMeetings = _meetings.where((meeting) {
          final title = (meeting['title'] as String).toLowerCase();
          final date = (meeting['date'] as String).toLowerCase();
          return title.contains(query.toLowerCase()) ||
              date.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> _refreshMeetings() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
      // In real app, this would fetch new data
      _filteredMeetings = List.from(_meetings);
    });
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Meetings',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            _buildFilterOption('All Meetings', true),
            _buildFilterOption('Completed', false),
            _buildFilterOption('Processing', false),
            _buildFilterOption('Recorded', false),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String title, bool isSelected) {
    return ListTile(
      title: Text(title),
      trailing: isSelected
          ? CustomIconWidget(
              iconName: 'check_circle',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            )
          : CustomIconWidget(
              iconName: 'radio_button_unchecked',
              color: AppTheme.lightTheme.colorScheme.outline,
              size: 24,
            ),
      onTap: () {
        // Handle filter selection
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            DashboardHeaderWidget(
              onNotificationTap: () {
                // Handle notification tap
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications opened')),
                );
              },
              onAvatarTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            SearchBarWidget(
              isCollapsed: _isSearchCollapsed,
              onSearchChanged: _filterMeetings,
              onFilterTap: _showFilterDialog,
            ),
            Expanded(
              child: _filteredMeetings.isEmpty && _searchQuery.isEmpty
                  ? EmptyStateWidget(
                      onStartRecording: () {
                        Navigator.pushNamed(context, '/voice-recording');
                      },
                    )
                  : RefreshIndicator(
                      onRefresh: _refreshMeetings,
                      color: AppTheme.lightTheme.colorScheme.primary,
                      child: _filteredMeetings.isEmpty
                          ? _buildNoResultsWidget()
                          : ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: _filteredMeetings.length,
                              itemBuilder: (context, index) {
                                final meeting = _filteredMeetings[index];
                                return MeetingCardWidget(
                                  meeting: meeting,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/meeting-notes-detail');
                                  },
                                  onShare: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Sharing ${meeting['title']}')),
                                    );
                                  },
                                  onExport: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Exporting ${meeting['title']}')),
                                    );
                                  },
                                  onDelete: () {
                                    _deleteMeeting(meeting['id']);
                                  },
                                  onEdit: () {
                                    Navigator.pushNamed(
                                        context, '/meeting-notes-detail');
                                  },
                                  onDuplicate: () {
                                    _duplicateMeeting(meeting);
                                  },
                                  onMoveToFolder: () {
                                    _showMoveToFolderDialog(meeting);
                                  },
                                );
                              },
                            ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/voice-recording');
        },
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        child: CustomIconWidget(
          iconName: 'mic',
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildNoResultsWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'search_off',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 20.w,
            ),
            SizedBox(height: 3.h),
            Text(
              'No meetings found',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Try adjusting your search or filters',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            icon: CustomIconWidget(
              iconName: 'dashboard',
              color: _tabController.index == 0
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            text: 'Dashboard',
          ),
          Tab(
            icon: CustomIconWidget(
              iconName: 'mic',
              color: _tabController.index == 1
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            text: 'Record',
          ),
          Tab(
            icon: CustomIconWidget(
              iconName: 'upload_file',
              color: _tabController.index == 2
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            text: 'Upload',
          ),
          Tab(
            icon: CustomIconWidget(
              iconName: 'settings',
              color: _tabController.index == 3
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            text: 'Settings',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on dashboard
              break;
            case 1:
              Navigator.pushNamed(context, '/voice-recording');
              break;
            case 2:
              Navigator.pushNamed(context, '/audio-upload');
              break;
            case 3:
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
        labelColor: AppTheme.lightTheme.colorScheme.primary,
        unselectedLabelColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        indicatorColor: AppTheme.lightTheme.colorScheme.primary,
        labelStyle: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: AppTheme.lightTheme.textTheme.labelSmall,
      ),
    );
  }

  void _deleteMeeting(int meetingId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Meeting'),
        content: Text(
            'Are you sure you want to delete this meeting? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _meetings.removeWhere((meeting) => meeting['id'] == meetingId);
                _filteredMeetings
                    .removeWhere((meeting) => meeting['id'] == meetingId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Meeting deleted')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightTheme.colorScheme.error,
            ),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _duplicateMeeting(Map<String, dynamic> meeting) {
    final duplicatedMeeting = Map<String, dynamic>.from(meeting);
    duplicatedMeeting['id'] = _meetings.length + 1;
    duplicatedMeeting['title'] = '${meeting['title']} (Copy)';
    duplicatedMeeting['date'] =
        'Aug 26, 2025 • ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}';

    setState(() {
      _meetings.insert(0, duplicatedMeeting);
      _filterMeetings(_searchQuery);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Meeting duplicated')),
    );
  }

  void _showMoveToFolderDialog(Map<String, dynamic> meeting) {
    final folders = ['Work', 'Personal', 'Client Meetings', 'Team Meetings'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Move to Folder',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            ...folders
                .map((folder) => ListTile(
                      leading: CustomIconWidget(
                        iconName: 'folder',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 24,
                      ),
                      title: Text(folder),
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Moved to $folder')),
                        );
                      },
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
