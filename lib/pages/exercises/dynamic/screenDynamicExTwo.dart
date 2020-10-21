import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';
import 'package:morningmagic/utils/shared_preferences.dart';
import 'package:morningmagic/view/customAppBar.dart';
import 'package:morningmagic/view/customBottomExerciseNavigation.dart';

class DynamicExerciseTwoScreen extends StatefulWidget {
  @override
  State createState() {
    return DynamicExerciseTwoScreenState();
  }
}

class DynamicExerciseTwoScreenState extends State<DynamicExerciseTwoScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  TimerAppBar timerAppBar;

  Future<bool> _onWillPop() async {
    await ExerciseUtils().goPreviousRoute();

    assetsAudioPlayer.stop();
    assetsAudioPlayer.dispose();
    timerAppBar.cancelTimer();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    timerAppBar =
        TimerAppBar(AppLocalizations.of(context).translate("exercise_2_title"));
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: timerAppBar,
          ),
          body: Center(
            child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // match parent(all screen)
                height: MediaQuery.of(context)
                    .size
                    .height, // match parent(all screen)
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.TOP_GRADIENT,
                      AppColors.MIDDLE_GRADIENT,
                      AppColors.BOTTOM_GRADIENT
                    ],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 270,
                      child: LayoutBuilder(
                        builder: (BuildContext context,
                            BoxConstraints viewportConstraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 25),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("exercise_2"),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "rex",
                                              fontStyle: FontStyle.normal,
                                              color: AppColors.WHITE,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate("exercise_2_title"),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: "rex",
                                            color: AppColors.WHITE,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 20, left: 20, bottom: 30),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("exercise_2_text_1"),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "JMH",
                                        height: 1.7,
                                        color: AppColors.VIOLET,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                        left: 20.0, right: 20.0, bottom: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .translate("exercise_2_text_2"),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "JMH",
                                                height: 1.7,
                                                color: AppColors.VIOLET,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child:
                            BottomExerciseNavigation(soundCallback: () async {
                          bool result =
                              await CustomSharedPreferences().getVoice();
                          if (result) {
                            // man voice
                            assetsAudioPlayer.open(
                              Audio(AppLocalizations.of(context)
                                  .translate("exercise_two_sound")),
                            );
                          } else {
                            // woman voice
                            assetsAudioPlayer.open(
                              Audio("assets/audios/2w.mp3"),
                            );
                          }
                          assetsAudioPlayer.play();
                        }, nextCallback: () {
                          timerAppBar.cancelTimer();
                          ExerciseUtils().goNextRoute(context);
                          assetsAudioPlayer.stop();
                          assetsAudioPlayer.dispose();
                        }))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
