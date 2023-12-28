import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';


class CallingScreen extends StatefulWidget {
  final String channelName;

  const CallingScreen({Key? key, required this.channelName}) : super(key: key);

  @override
  _CallingScreenState createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  late RtcEngine _engine;
  bool isMuted = false;
  bool isVideoEnabled = true;

  @override
  void initState() {
    super.initState();
    initializeAgora();
    _handleCameraAndMic();
  }

  Future<void> initializeAgora() async {
    // Initialize Agora with your App ID
    const agoraAppId = 'e35974b9d4974d0fa6b7ed6d0574e813';

    // Create the engine using RtcEngineContext
    _engine = await RtcEngine.create(RtcEngineContext(agoraAppId));

    await _engine.enableVideo();

    // Join the channel with appropriate parameters
    await _engine.joinChannel(null, widget.channelName, null, 0);
  }

  Future<void> _handleCameraAndMic() async {
    await [Permission.camera, Permission.microphone].request();
  }

 @override
  void dispose() async {
    await _engine.leaveChannel();
    await _engine.destroy(); // Use await for proper cleanup
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calling ${widget.channelName}'),
        actions: [
          IconButton(
            icon: Icon(isMuted ? Icons.mic_off : Icons.mic),
            onPressed: () async {
              isMuted = !isMuted;
              await _engine.muteLocalAudioStream(isMuted);
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(isVideoEnabled ? Icons.videocam : Icons.videocam_off),
            onPressed: () async {
              isVideoEnabled = !isVideoEnabled;
              await _engine.enableLocalVideo(isVideoEnabled);
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.call_end),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Local video view
          RtcLocalView.SurfaceView(
            zOrder: 1,
            mirrorMode: true, // Optional: mirror local video
          ),
          // Remote video view (shows when other users join)
          RtcRemoteView.SurfaceView(
            zOrder: 2,
          ),
        ],
      ),
    );
  }
}
