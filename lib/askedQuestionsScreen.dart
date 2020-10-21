import 'dart:collection';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/progress/affirmation_progress/affirmation_progress.dart';
import 'package:morningmagic/db/model/progress/fitness_porgress/fitness_progress.dart';
import 'package:morningmagic/db/model/progress/meditation_progress/meditation_progress.dart';
import 'package:morningmagic/db/model/progress/reading_progress/reading_progress.dart';
import 'package:morningmagic/db/model/progress/visualization_progress/visualization_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/dialog/startAgainDialog.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';
import 'package:morningmagic/view/progressItem.dart';
import 'package:morningmagic/view/progressItemHeader.dart';
import 'package:morningmagic/view/progressItemRecord.dart';

import 'db/model/progress/day/day.dart';
import 'db/model/progress/progress_object.dart';
import 'db/model/progress/vocabulary_progress/vocabulary_note_progress.dart';
import 'db/model/progress/vocabulary_progress/vocabulary_record_progress.dart';

class AskedQuestionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AskedQuestionsState();
  }
}

class _AskedQuestionsState extends State<AskedQuestionsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width, // match parent(all screen)
          height:
              MediaQuery.of(context).size.height, // match parent(all screen)
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
              AppColors.TOP_GRADIENT,
              AppColors.MIDDLE_GRADIENT,
              AppColors.BOTTOM_GRADIENT,
            ],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 15,
                    bottom: MediaQuery.of(context).size.height / 50),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("progress"),
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: "sans-serif-black",
                      fontStyle: FontStyle.normal,
                      color: AppColors.WHITE,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                    colors: [
                      AppColors.FIX_TOP,
                      AppColors.MIDDLE_GRADIENT,
                      AppColors.FIX_BOTTOM,
                    ],
                  )),
                  child: FutureBuilder(
                    future: ProgressUtil().getDataMap(),
                    builder: (BuildContext context,
                        AsyncSnapshot<HashMap<String, List<Day>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        List<ProgressObject> list = ProgressUtil()
                            .createProgressObjectsList(snapshot.data);
                        return ListView.builder(
                          itemCount: list.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              margin: EdgeInsets.only(
                                  left: 24, bottom: 8, right: 24),
                              child: ExpandableNotifier(
                                child: Column(
                                  children: <Widget>[
                                    ScrollOnExpand(
                                      scrollOnExpand: true,
                                      scrollOnCollapse: false,
                                      child: ExpandablePanel(
                                        theme: ExpandableThemeData(
                                          animationDuration:
                                              Duration(milliseconds: 500),
                                          hasIcon: false,
                                          crossFadePoint: 0.5,
                                          tapBodyToCollapse: true,
                                          headerAlignment:
                                              ExpandablePanelHeaderAlignment
                                                  .center,
                                          tapHeaderToExpand: true,
                                          iconPlacement:
                                              ExpandablePanelIconPlacement
                                                  .right,
                                          iconPadding: EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 15,
                                          ),
                                        ),
                                        header: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                    child: ProgressItemHeader(
                                                        (index + 1).toString() +
                                                            " " +
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    "day") +
                                                            " - " +
                                                            list[index].date)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        expanded: Padding(
                                          padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          child: Container(
                                              child: getProgressBodyWidget(
                                                  list[index].dayList)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 10,
                    left: MediaQuery.of(context).size.width / 4.5,
                    right: MediaQuery.of(context).size.width / 4.5,
                    bottom: 10),
                child: AnimatedButton(() {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/start', (r) => false);
                }, 'sans-serif', AppLocalizations.of(context).translate("menu"),
                    22, null, null),
              ),
//                Container(
//                  height: 67,
//                  padding: EdgeInsets.only(
//                      left: MediaQuery.of(context).size.width / 4.5,
//                      right: MediaQuery.of(context).size.width / 4.5,
//                      bottom: MediaQuery.of(context).size.height / 50,
//                      top: MediaQuery.of(context).size.height / 50),
//                  child: AnimatedButton(() {
//                    showDialog(
//                        context: context,
//                        builder: (BuildContext context) => StartAgainDialog());
//                  }, 'sans-serif', AppLocalizations.of(context).translate("restart"), 22, null, null),
//                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getProgressBodyWidget(List<Day> days) {
    print(days.length.toString() + " length");
    return Column(
      children: createRowsByDays(days),
    );
  }

  List<Widget> createRowsByDays(List<Day> days) {
    List<Widget> list = new List();
    for (int i = 0; i < days.length; i++) {
      list.add(createRow(days[i]));
    }
    return list;
  }

  Widget createRow(Day day) {
    AffirmationProgress affirmationProgress = day.affirmationProgress;
    MeditationProgress meditationProgress = day.meditationProgress;
    FitnessProgress fitnessProgress = day.fitnessProgress;
    ReadingProgress readingProgress = day.readingProgress;
    VocabularyNoteProgress vocabularyNoteProgress = day.vocabularyNoteProgress;
    VocabularyRecordProgress vocabularyRecordProgress =
        day.vocabularyRecordProgress;
    VisualizationProgress visualizationProgress = day.visualizationProgress;
    String value;

    if (affirmationProgress != null) {
      value = createMinutesStringFromSeconds(affirmationProgress.seconds);
      value = value + ", " + affirmationProgress.text;
      return ProgressPair(
          AppLocalizations.of(context).translate("affirmation_small"), value);
    } else if (meditationProgress != null) {
      value = createMinutesStringFromSeconds(meditationProgress.seconds);
      return ProgressPair(
          AppLocalizations.of(context).translate("meditation_small"), value);
    } else if (visualizationProgress != null) {
      value = createMinutesStringFromSeconds(visualizationProgress.seconds);
      value = value + ", " + visualizationProgress.text;
      return ProgressPair(
          AppLocalizations.of(context).translate("visualization_small"), value);
    } else if (fitnessProgress != null) {
      value = createMinutesStringFromSeconds(fitnessProgress.seconds);
      value = value + ", " + fitnessProgress.exercise;
      return ProgressPair(
          AppLocalizations.of(context).translate("fitness_small"), value);
    } else if (readingProgress != null) {
      value = readingProgress.book;
      value = value + ", " + readingProgress.pages.toString();
      return ProgressPair(
          AppLocalizations.of(context).translate("reading_small"), value);
    } else if (vocabularyNoteProgress != null) {
      value = vocabularyNoteProgress.note;
      return ProgressPair(
          AppLocalizations.of(context).translate("diary_small"), value);
    } else {
      return ProgressPairRecord(
          AppLocalizations.of(context).translate("diary_small"),
          vocabularyRecordProgress.path);
    }
  }

  String createMinutesStringFromSeconds(int sec) {
    String result = "";

    int minutes = sec ~/ 60;
    int seconds = sec % 60;

    if (minutes > 0) {
      result = minutes.toString() +
          " " +
          AppLocalizations.of(context).translate("min") +
          " " +
          seconds.toString() +
          " " +
          AppLocalizations.of(context).translate("sec");
    } else {
      result =
          sec.toString() + " " + AppLocalizations.of(context).translate("sec");
    }

    return result;
  }
}
