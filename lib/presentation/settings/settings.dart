import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/account_section_widget.dart';
import './widgets/integration_item_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/storage_usage_widget.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // Mock user profile data
  final Map<String, dynamic> userProfile = {
    "id": 1,
    "name": "Sarah Johnson",
    "email": "sarah.johnson@company.com",
    "avatar":
        "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
    "subscription": "Pro",
    "joinDate": "2024-01-15",
  };

  // Mock storage data
  final Map<String, dynamic> storageData = {
    "totalUsed": 2.4,
    "totalLimit": 5.0,
    "breakdown": {
      "audioFiles": 1.2,
      "transcripts": 0.8,
      "cachedData": 0.4,
    }
  };

  // Mock integrations data
  final List<Map<String, dynamic>> integrations = [
    {
      "id": 1,
      "name": "Google Docs",
      "description": "Export meeting notes directly to Google Docs",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/0/01/Google_Docs_logo_%282014-2020%29.svg",
      "connected": true,
      "lastSync": "2 hours ago",
    },
    {
      "id": 2,
      "name": "Notion",
      "description": "Sync notes with your Notion workspace",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/4/45/Notion_app_logo.png",
      "connected": true,
      "lastSync": "1 day ago",
    },
    {
      "id": 3,
      "name": "Slack",
      "description": "Auto-post meeting summaries to Slack channels",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/d/d5/Slack_icon_2019.svg",
      "connected": false,
      "lastSync": null,
    },
    {
      "id": 4,
      "name": "Trello",
      "description": "Create cards from action items automatically",
      "logo": "https://upload.wikimedia.org/wikipedia/en/8/8c/Trello_logo.svg",
      "connected": true,
      "lastSync": "3 hours ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),

            // Account Section
            AccountSectionWidget(
              userProfile: userProfile,
              onAccountTap: () => _handleAccountTap(),
            ),

            // Recording Preferences
            SettingsSectionWidget(
              title: 'Recording Preferences',
              items: [
                {
                  'key': 'audio_quality',
                  'title': 'Audio Quality',
                  'subtitle': 'High quality recordings use more storage',
                  'icon': 'high_quality',
                  'type': 'dropdown',
                  'value': 'High',
                },
                {
                  'key': 'auto_delete',
                  'title': 'Auto-delete Original Files',
                  'subtitle': 'Delete audio files after transcription',
                  'icon': 'delete_forever',
                  'type': 'switch',
                  'value': true,
                },
                {
                  'key': 'language',
                  'title': 'Language',
                  'subtitle': 'Speech recognition language',
                  'icon': 'language',
                  'type': 'dropdown',
                  'value': 'English',
                },
              ],
              onItemTap: _handleSettingsTap,
            ),

            // AI Processing
            SettingsSectionWidget(
              title: 'AI Processing',
              items: [
                {
                  'key': 'summary_style',
                  'title': 'Summary Style',
                  'subtitle': 'Choose between detailed or concise summaries',
                  'icon': 'summarize',
                  'type': 'dropdown',
                  'value': 'Detailed',
                },
                {
                  'key': 'custom_prompts',
                  'title': 'Custom Prompt Templates',
                  'subtitle': 'Create custom AI processing templates',
                  'icon': 'edit_note',
                  'type': 'navigation',
                },
                {
                  'key': 'speaker_id',
                  'title': 'Speaker Identification',
                  'subtitle': 'Identify different speakers in recordings',
                  'icon': 'record_voice_over',
                  'type': 'switch',
                  'value': false,
                },
              ],
              onItemTap: _handleSettingsTap,
            ),

            // Integrations Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Text(
                'Integrations',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            ),

            ...integrations
                .map((integration) => IntegrationItemWidget(
                      integration: integration,
                      onTap: () =>
                          _handleIntegrationTap(integration['name'] as String),
                    ))
                .toList(),

            // Storage Usage
            StorageUsageWidget(
              storageData: storageData,
              onClearCache: _handleClearCache,
            ),

            // Privacy & Security
            SettingsSectionWidget(
              title: 'Privacy & Security',
              items: [
                {
                  'key': 'data_retention',
                  'title': 'Data Retention Policy',
                  'subtitle': 'Manage how long data is stored',
                  'icon': 'policy',
                  'type': 'navigation',
                },
                {
                  'key': 'encryption',
                  'title': 'End-to-End Encryption',
                  'subtitle': 'All data is encrypted and secure',
                  'icon': 'lock',
                  'type': 'status',
                  'connected': true,
                },
                {
                  'key': 'delete_account',
                  'title': 'Delete Account',
                  'subtitle': 'Permanently delete your account and data',
                  'icon': 'delete_forever',
                  'type': 'navigation',
                },
              ],
              onItemTap: _handleSettingsTap,
            ),

            // Notifications
            SettingsSectionWidget(
              title: 'Notifications',
              items: [
                {
                  'key': 'processing_complete',
                  'title': 'Processing Complete',
                  'subtitle': 'Notify when transcription is finished',
                  'icon': 'notifications',
                  'type': 'switch',
                  'value': true,
                },
                {
                  'key': 'sharing_alerts',
                  'title': 'Sharing Alerts',
                  'subtitle': 'Notify when notes are shared with you',
                  'icon': 'share',
                  'type': 'switch',
                  'value': true,
                },
                {
                  'key': 'integration_sync',
                  'title': 'Integration Sync',
                  'subtitle': 'Notify about integration sync status',
                  'icon': 'sync',
                  'type': 'switch',
                  'value': false,
                },
              ],
              onItemTap: _handleSettingsTap,
            ),

            // Help & Support
            SettingsSectionWidget(
              title: 'Help & Support',
              items: [
                {
                  'key': 'faq',
                  'title': 'FAQ',
                  'subtitle': 'Frequently asked questions',
                  'icon': 'help',
                  'type': 'navigation',
                },
                {
                  'key': 'contact_support',
                  'title': 'Contact Support',
                  'subtitle': 'Get help from our support team',
                  'icon': 'support_agent',
                  'type': 'navigation',
                },
                {
                  'key': 'app_version',
                  'title': 'App Version',
                  'subtitle': 'RemoteNotes AI v2.1.0',
                  'icon': 'info',
                  'type': 'info',
                },
              ],
              onItemTap: _handleSettingsTap,
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  void _handleAccountTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAccountBottomSheet(),
    );
  }

  Widget _buildAccountBottomSheet() {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 10.w,
            height: 0.5.h,
            margin: EdgeInsets.symmetric(vertical: 1.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Account Management',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  _buildSubscriptionCard(),
                  SizedBox(height: 2.h),
                  _buildBillingHistory(),
                  SizedBox(height: 2.h),
                  _buildUpgradeOptions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.lightTheme.colorScheme.primary,
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Plan',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pro Plan',
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '\$19.99/month',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            'Next billing: January 15, 2025',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingHistory() {
    final billingHistory = [
      {"date": "Dec 15, 2024", "amount": "\$19.99", "status": "Paid"},
      {"date": "Nov 15, 2024", "amount": "\$19.99", "status": "Paid"},
      {"date": "Oct 15, 2024", "amount": "\$19.99", "status": "Paid"},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Billing History',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          ...billingHistory
              .map((bill) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bill['date'] as String,
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                            Text(
                              bill['status'] as String,
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          bill['amount'] as String,
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildUpgradeOptions() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upgrade Options',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.tertiary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Team Plan',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\$49.99/month',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightTheme.colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  'Perfect for teams with advanced collaboration features',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showUpgradeDialog();
                    },
                    child: Text('Upgrade to Team'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSettingsTap(String key) {
    switch (key) {
      case 'delete_account':
        _showDeleteAccountDialog();
        break;
      case 'data_retention':
        _showDataRetentionDialog();
        break;
      case 'custom_prompts':
        // Navigate to custom prompts screen
        break;
      default:
        // Handle other settings
        break;
    }
  }

  void _handleIntegrationTap(String integrationName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildIntegrationBottomSheet(integrationName),
    );
  }

  Widget _buildIntegrationBottomSheet(String integrationName) {
    final integration = integrations.firstWhere(
      (item) => item['name'] == integrationName,
    );

    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 10.w,
            height: 0.5.h,
            margin: EdgeInsets.symmetric(vertical: 1.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  integrationName,
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Container(
                        width: 15.w,
                        height: 15.w,
                        decoration: BoxDecoration(
                          color:
                              AppTheme.lightTheme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomImageWidget(
                          imageUrl: integration['logo'] as String,
                          width: 15.w,
                          height: 15.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              integration['description'] as String,
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 1.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: (integration['connected'] as bool)
                                    ? AppTheme.lightTheme.colorScheme.tertiary
                                        .withValues(alpha: 0.1)
                                    : AppTheme.lightTheme.colorScheme.error
                                        .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                (integration['connected'] as bool)
                                    ? 'Connected'
                                    : 'Disconnected',
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: (integration['connected'] as bool)
                                      ? AppTheme.lightTheme.colorScheme.tertiary
                                      : AppTheme.lightTheme.colorScheme.error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  if (integration['connected'] as bool) ...[
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showDisconnectDialog(integrationName);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              AppTheme.lightTheme.colorScheme.error,
                          side: BorderSide(
                              color: AppTheme.lightTheme.colorScheme.error),
                        ),
                        child: Text('Disconnect'),
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _connectIntegration(integrationName);
                        },
                        child: Text('Connect'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleClearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Cache'),
        content: Text(
            'This will clear all cached data and free up storage space. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performClearCache();
            },
            child: Text('Clear Cache'),
          ),
        ],
      ),
    );
  }

  void _performClearCache() {
    // Simulate cache clearing
    setState(() {
      storageData['breakdown']['cachedData'] = 0.0;
      storageData['totalUsed'] = (storageData['totalUsed'] as double) - 0.4;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cache cleared successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text(
            'Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login-screen');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightTheme.colorScheme.error,
            ),
            child: Text('Delete Account'),
          ),
        ],
      ),
    );
  }

  void _showDataRetentionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Data Retention Policy'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Settings:',
                style: AppTheme.lightTheme.textTheme.titleSmall),
            SizedBox(height: 1.h),
            Text('• Audio files: 30 days'),
            Text('• Transcripts: 1 year'),
            Text('• Meeting notes: Indefinitely'),
            SizedBox(height: 2.h),
            Text(
                'You can modify these settings to comply with your organization\'s data retention policies.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Modify Settings'),
          ),
        ],
      ),
    );
  }

  void _showUpgradeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upgrade to Team Plan'),
        content: Text(
            'Upgrade to Team Plan for \$49.99/month and unlock advanced collaboration features, unlimited storage, and priority support.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Redirecting to payment...'),
                  backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                ),
              );
            },
            child: Text('Upgrade Now'),
          ),
        ],
      ),
    );
  }

  void _showDisconnectDialog(String integrationName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Disconnect $integrationName'),
        content: Text(
            'Are you sure you want to disconnect $integrationName? You will no longer be able to sync data with this service.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _disconnectIntegration(integrationName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightTheme.colorScheme.error,
            ),
            child: Text('Disconnect'),
          ),
        ],
      ),
    );
  }

  void _connectIntegration(String integrationName) {
    // Simulate connection process
    setState(() {
      final index =
          integrations.indexWhere((item) => item['name'] == integrationName);
      if (index != -1) {
        integrations[index]['connected'] = true;
        integrations[index]['lastSync'] = 'Just now';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$integrationName connected successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      ),
    );
  }

  void _disconnectIntegration(String integrationName) {
    // Simulate disconnection process
    setState(() {
      final index =
          integrations.indexWhere((item) => item['name'] == integrationName);
      if (index != -1) {
        integrations[index]['connected'] = false;
        integrations[index]['lastSync'] = null;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$integrationName disconnected'),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
      ),
    );
  }
}
