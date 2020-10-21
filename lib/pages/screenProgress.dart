import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';

class ProgressScreen extends StatefulWidget {
  @override
  State createState() {
    return ProgressScreenState();
  }
}

class ProgressScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: _onWillPop,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 35),
                      child: Text(
                        AppLocalizations.of(context).translate("progress"),
                        style: TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.normal,
                          fontFamily: "sans-serif-black",
                          color: AppColors.WHITE,
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context).translate("progress_title"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "sans-serif",
                        fontStyle: FontStyle.normal,
                        color: AppColors.VIOLET,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 75,
                  child: AnimatedButton(() {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/start', (r) => false);
                  },
                      'sans-serif',
                      AppLocalizations.of(context).translate("back_button"),
                      22,
                      null,
                      null),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<bool> _onWillPop() async {
    Navigator.pushNamedAndRemoveUntil(context, '/start', (r) => false);
    return false;
  }
}
