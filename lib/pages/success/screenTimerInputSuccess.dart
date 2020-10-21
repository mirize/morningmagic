import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/customInputNextColumn.dart';
import 'package:morningmagic/view/custom_progress_bar/arcProgressBar.dart';
import 'package:vibration/vibration.dart';

class TimerInputSuccessScreen extends StatefulWidget {
  @override
  State createState() {
    return TimerInputSuccessScreenState();
  }
}

class TimerInputSuccessScreenState extends State<TimerInputSuccessScreen> {
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
    return SafeArea(
        child: WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
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
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.7,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ArcProgressBar(
                              text: AppLocalizations.of(context)
                                  .translate("success"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 17,
                                bottom:
                                    MediaQuery.of(context).size.height / 17),
                            child: InputTextColumn(() {
                              if (assetsAudioPlayer != null) {
                                assetsAudioPlayer.stop();
                                assetsAudioPlayer.dispose();
                              }
//                            }, widget.seconds, widget.bookTitle, widget.box),
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    ));
  }

  Future<bool> _onWillPop() async {
    if (assetsAudioPlayer != null) {
      assetsAudioPlayer.stop();
      assetsAudioPlayer.dispose();
    }
    return true;
  }
}
