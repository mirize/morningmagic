import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/pages/screenNote.dart';
import 'package:morningmagic/pages/success/screenTimerRecordSuccess.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';

class VocabularyScreen extends StatefulWidget {
  @override
  State createState() {
    return VocabularyScreenState();
  }
}

class VocabularyScreenState extends State<VocabularyScreen> {
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
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  bottom: (MediaQuery.of(context).size.height / 2),
                  child: Text(
                    AppLocalizations.of(context).translate("diary"),
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: "rex",
                      fontStyle: FontStyle.normal,
                      color: AppColors.WHITE,
                    ),
                  ),
                ),
                Positioned(
                  bottom: (MediaQuery.of(context).size.height / 2) -
                      (MediaQuery.of(context).size.height / 2 / 2.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 15),
                        child: AnimatedButton(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TimerRecordSuccessScreen()));
                        },
                            'rex',
                            AppLocalizations.of(context)
                                .translate("voice_record"),
                            20,
                            220.0,
                            null),
                      ),
                      AnimatedButton(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteScreen()));
                      },
                          'rex',
                          AppLocalizations.of(context)
                              .translate("written_record"),
                          20,
                          220.0,
                          null)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
