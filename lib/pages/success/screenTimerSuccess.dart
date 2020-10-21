import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';
import 'package:morningmagic/view/custom_progress_bar/arcProgressBar.dart';
import 'package:vibration/vibration.dart';

class TimerSuccessScreen extends StatefulWidget {
  final VoidCallback onPressed;

  TimerSuccessScreen(this.onPressed);

  @override
  State createState() {
    return TimerSuccessScreenState();
  }
}

class TimerSuccessScreenState extends State<TimerSuccessScreen> {
  AssetsAudioPlayer assetsAudioPlayer;

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(Audio("assets/audios/success.mp3"));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  Future<void> _asyncMethod() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (assetsAudioPlayer != null) {
      assetsAudioPlayer.stop();
      assetsAudioPlayer.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: SafeArea(
          child: Scaffold(
        body: SafeArea(
          child: Container(
            width:
                MediaQuery.of(context).size.width, // match parent(all screen)
            height:
                MediaQuery.of(context).size.height, // match parent(all screen)
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.TOP_GRADIENT,
                AppColors.MIDDLE_GRADIENT,
                AppColors.BOTTOM_GRADIENT
              ],
            )),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ArcProgressBar(
                    text: AppLocalizations.of(context).translate("success"),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 5.5,
                  child: AnimatedButton(() async {
                    if (assetsAudioPlayer != null) {
                      assetsAudioPlayer.stop();
                      assetsAudioPlayer.dispose();
                    }
                    widget.onPressed();
                  }, 'rex', AppLocalizations.of(context).translate("continue"),
                      21, null, null),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<bool> _onWillPop() async {
    if (assetsAudioPlayer != null) {
      assetsAudioPlayer.stop();
      assetsAudioPlayer.dispose();
    }
    return true;
  }
}
