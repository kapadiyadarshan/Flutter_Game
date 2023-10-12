import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class SoundController extends ChangeNotifier {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  loseSound() {
    assetsAudioPlayer.open(
      Audio("asset/audio/lose.mp3"),
      autoStart: true,
    );
  }

  winSound() {
    assetsAudioPlayer.open(
      Audio("asset/audio/win.mp3"),
      autoStart: true,
    );
  }
}
