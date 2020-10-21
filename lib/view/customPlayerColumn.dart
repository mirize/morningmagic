import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/pages/screenNote.dart';
import 'package:morningmagic/pages/screenReading.dart';
import 'package:morningmagic/pages/success/screenTimerSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/view/sound_waves_diagram/my/line_box.dart';

import '../toastUtils.dart';

class PlayerColumn extends StatefulWidget {
  final VoidCallback onPressed;
  final VoidCallback playCallback;
  final VoidCallback stopCallback;

  PlayerColumn(this.onPressed, this.playCallback, this.stopCallback);

  @override
  State createState() {
    return PlayerColumnState();
  }
}

class PlayerColumnState extends State<PlayerColumn> {
  bool pauseSwitch = false;
  LineBox lineBox = LineBox();
  bool visibleDiagram = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2.2,
                height: 53,
                child: Container(
//                  decoration: BoxDecoration(
//                      color: AppColors.WHITE,
//                      borderRadius: BorderRadius.all(Radius.circular(40))
//                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: 53,
                    child: Visibility(
                      child: lineBox,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: visibleDiagram,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      spreadRadius: -15,
                      offset: Offset(
                        1.0, // horizontal, move right 10
                        1.0, // vertical, move down 10
                      ),
                    )
                  ]),
                  child: GestureDetector(
                    onTap: () {
                      visibleDiagram = true;
                      widget.playCallback();
                      setState(() {
                        pauseSwitch = !pauseSwitch;
                        if (pauseSwitch) {
                          lineBox.playAnimation();
                        } else {
                          lineBox.stopAnimation();
                        }
                      });
                    },
                    child: Icon(
                      pauseSwitch ? Icons.pause : Icons.circle,
                      size: 35,
                      color: AppColors.VIOLET,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      spreadRadius: -15,
                      offset: Offset(
                        1.0, // horizontal, move right 10
                        1.0, // vertical, move down 10
                      ),
                    )
                  ]),
                  child: GestureDetector(
                    onTap: () {
                      visibleDiagram = false;
                      lineBox.stopAnimation();
                      widget.stopCallback();
                      setState(() {
                        pauseSwitch = false;
                      });
                    },
                    child: Icon(
                      Icons.stop,
                      size: 40,
                      color: AppColors.VIOLET,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 30),
          child: ButtonTheme(
            minWidth: 170.0,
            height: 50.0,
            child: RaisedButton(
              elevation: 0,
              onPressed: () {
                OrderUtil().getRouteById(3).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TimerSuccessScreen(() {
                                Navigator.push(context, value);
                              })));
                });
                visibleDiagram = false;
                widget.onPressed();
                setState(() {
                  pauseSwitch = false;
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(38.0)),
              child: Text(
                AppLocalizations.of(context).translate("continue"),
                style: TextStyle(
                  color: AppColors.WHITE,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'rex',
                  fontSize: 21,
                ),
              ),
              color: AppColors.PINK,
            ),
          ),
        ),
      ],
    );
  }
}
