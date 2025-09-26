import 'package:flutter/material.dart';
import '../presentation/settings/settings.dart';
import '../presentation/audio_upload/audio_upload.dart';
import '../presentation/meeting_notes_detail/meeting_notes_detail.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/dashboard/dashboard.dart';
import '../presentation/voice_recording/voice_recording.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String settings = '/settings';
  static const String audioUpload = '/audio-upload';
  static const String meetingNotesDetail = '/meeting-notes-detail';
  static const String login = '/login-screen';
  static const String dashboard = '/dashboard';
  static const String voiceRecording = '/voice-recording';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    settings: (context) => const Settings(),
    audioUpload: (context) => const AudioUpload(),
    meetingNotesDetail: (context) => const MeetingNotesDetail(),
    login: (context) => const LoginScreen(),
    dashboard: (context) => const Dashboard(),
    voiceRecording: (context) => const VoiceRecording(),
    // TODO: Add your other routes here
  };
}
