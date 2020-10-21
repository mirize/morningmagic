import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/visualization/visualization.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/timer/screenTimerVizualization.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';

class VisualizationScreen extends StatefulWidget {
  @override
  State createState() {
    return VisualizationScreenState();
  }
}

class VisualizationScreenState extends State<VisualizationScreen> {
  Box box;
  TextEditingController textEditingController;

  String getInputString() {
    String result = "";
    Visualization visualization = box.get(Resource.VISUALIZATION_KEY);
    if (visualization != null) {
      result = visualization.visualization;
    }
    return result;
  }

  @override
  void initState() {
    getBox().then((value) {
      setState(() {
        box = value;

        textEditingController =
            new TextEditingController(text: getInputString());
        textEditingController.addListener(() {
          saveVisualization();
        });
      });
    });
    super.initState();
  }

  Future<Box> getBox() async {
    await Hive.initFlutter();
    box = await Hive.openBox(Resource.BOX_NAME);
    return box;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
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
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3,
                            bottom: MediaQuery.of(context).size.height / 26,
                          ),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("visualization"),
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: "rex",
                              fontStyle: FontStyle.normal,
                              color: AppColors.WHITE,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 28,
                          ),
                          child: Container(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("visualization_title"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: "JMH",
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.VIOLET,
                                  height: 1.3),
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height / 15,
                              right: MediaQuery.of(context).size.height / 15,
                            ),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: AppColors.TRANSPARENT_WHITE,
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 18, bottom: 17, left: 20, right: 20),
                                  child: TextField(
                                    controller: textEditingController,
                                    minLines: 3,
                                    maxLines: 3,
                                    cursorColor: AppColors.VIOLET,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: "rex",
                                        fontStyle: FontStyle.normal,
                                        color: AppColors.VIOLET,
                                        decoration: TextDecoration.none),
                                    decoration: InputDecoration(
                                      hintMaxLines: 4,
                                      hintText: AppLocalizations.of(context)
                                          .translate("visualization_hint"),
                                      hintStyle: TextStyle(
                                        color: AppColors.LIGHT_GRAY,
                                        fontSize: 16,
                                        fontFamily: "rex",
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ))),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 30,
                              bottom: MediaQuery.of(context).size.height / 22),
                          child: AnimatedButton(() {
                            saveVisualization();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TimerVisualizationScreen()));
                          },
                              'rex',
                              AppLocalizations.of(context)
                                  .translate("next_button"),
                              22,
                              null,
                              null),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void saveVisualization() {
    if (textEditingController.text != null &&
        textEditingController.text.isNotEmpty) {
      box.put(Resource.VISUALIZATION_KEY,
          Visualization(textEditingController.text));
    }
  }
}
