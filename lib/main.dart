import 'package:flutter/material.dart';
import 'package:message_screen/screens/message_screen.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

void main() async {
  // Run the app
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messaging App',
      home: MessagingScreen(),
      // routes: {
      //   '/call': (context) => CallingScreen(channelName: 'YOUR_CHANNEL_NAME'),
      // },
    );
  }
}

// Omit this code, its a repition of the code in lib/screens/callingscreen.dart
// Future<void> initializeAgora() async {
//   const agoraAppId = 'e35974b9d4974d0fa6b7ed6d0574e813';
//   final engine =
//       await RtcEngine.createAgoraRtcEngine(RtcEngineContext(agoraAppId));
//   await engine.enableVideo();
//   // Add more Agora initialization as needed
// }
