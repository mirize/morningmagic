import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/note/note.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/vocabulary_progress/vocabulary_note_progress.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/view/animatedButton.dart';

class NoteScreen extends StatefulWidget {
  @override
  State createState() {
    return NoteScreenState();
  }
}

class NoteScreenState extends State<NoteScreen> {
  Box box;
  TextEditingController textEditingController;

  String getInputString() {
    Note note = box.get(Resource.NOTE_KEY, defaultValue: Note(""));
    return note.note;
  }

  Future<Box> initAndGetBox() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  Future<Box> openMyBox() async {
    return await Hive.openBox(Resource.BOX_NAME);
  }

  @override
  void initState() {
    openMyBox().then((value) {
      box = value;
      if (box == null) {
        initAndGetBox().then((value) {
          setState(() {
            box = value;
            initEditText();
          });
        });
      } else {
        setState(() {
          initEditText();
        });
      }
    });
    super.initState();
  }

  void initEditText() {
    textEditingController = new TextEditingController(text: getInputString());
    textEditingController.addListener(() {
      if (textEditingController.text != null &&
          textEditingController.text.isNotEmpty) {
        box.put(Resource.NOTE_KEY, Note(textEditingController.text));
      }
    });
  }

  void saveNoteProgress() {
    if (textEditingController.text != null &&
        textEditingController.text.isNotEmpty) {
      VocabularyNoteProgress noteProgress =
          VocabularyNoteProgress(textEditingController.text);
      Day day = ProgressUtil()
          .createDay(null, null, null, null, noteProgress, null, null);
      ProgressUtil().updateDayList(day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Center(
          child: Container(
              width:
                  MediaQuery.of(context).size.width, // match parent(all screen)
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
              )),
              child: LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 2.3,
                              bottom: MediaQuery.of(context).size.width / 7),
                          child: Text(
                            AppLocalizations.of(context).translate("note"),
                            style: TextStyle(
                              fontSize: 32,
                              fontStyle: FontStyle.normal,
                              fontFamily: "rex",
                              color: AppColors.WHITE,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 30,
                                right: MediaQuery.of(context).size.width / 30),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: AppColors.TRANSPARENT_WHITE,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: TextField(
                                    controller: textEditingController,
                                    minLines: 5,
                                    maxLines: 5,
                                    cursorColor: AppColors.VIOLET,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontFamily: "rex",
                                        fontStyle: FontStyle.normal,
                                        color: AppColors.VIOLET,
                                        decoration: TextDecoration.none),
                                    decoration: null,
                                  ),
                                ))),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 3,
                              bottom: MediaQuery.of(context).size.width / 5),
                          child: AnimatedButton(() {
                            saveNoteProgress();
                            OrderUtil().getRouteById(3).then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TimerSuccessScreen(() {
                                            Navigator.push(context, value);
                                          })));
                            });
                          },
                              'rex',
                              AppLocalizations.of(context)
                                  .translate("next_button"),
                              22,
                              null,
                              null),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ),
      ),
    ));
  }

  Future<bool> _onWillPop() async {
    saveNoteProgress();
    return true;
  }
}
