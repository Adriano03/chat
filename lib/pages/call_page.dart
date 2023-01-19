import 'dart:math';

import 'package:chat/key/save_key.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  final String callId;

  const CallPage({super.key, required this.callId});

  @override
  Widget build(BuildContext context) {
    final key = SaveKey();
    final String localUserId = Random().nextInt(10000).toString();
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: key.appId,
        appSign: key.appSign,
        callID: callId,
        userID: localUserId,
        userName: 'Usuário: $localUserId',
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) => Navigator.of(context).pop,
      ),
    );
  }
}
