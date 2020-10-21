import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/shared_preferences.dart';

import '../appLocalization.dart';

class VoiceSwitcher extends StatefulWidget {

  @override
  VoiceSwitcherState createState() {
    return VoiceSwitcherState();
  }
}

class VoiceSwitcherState extends State<VoiceSwitcher> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: 10, top: 10, bottom: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context).translate("player_voice"),
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.VIOLET,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'sans-serif-black',
                  fontSize: 26),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding:
            EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: FutureBuilder(
                      future: CustomSharedPreferences()
                          .getVoice(),
                      builder: (BuildContext context,
                          AsyncSnapshot<bool> value) {
                        return Text(AppLocalizations.of(context).translate("female"),
                            style: TextStyle(
                              color: chooseWomanColor(
                                  value.data == null
                                      ? true
                                      : value.data),
                              fontStyle:
                              FontStyle.normal,
                              fontSize: 20,
                              fontFamily: 'sans-serif',
                            ));
                      }),
                ),
                Container(
                  child: FutureBuilder(
                    future: CustomSharedPreferences()
                        .getVoice(),
                    builder: (BuildContext context,
                        AsyncSnapshot<bool> value) {
                      return Switch(
                        value: value.data == null
                            ? true
                            : value.data,
                        inactiveThumbColor:
                        AppColors.PINK,
                        inactiveTrackColor:
                        AppColors.PINK,
                        activeColor: AppColors.BLUE,
                        activeTrackColor:
                        AppColors.BLUE,
                        onChanged: (bool value) {
                          setState(() {
                            CustomSharedPreferences()
                                .setVoice(value);
                          });
                        },
                      );
                    },
                  ),
                ),
                Container(
                  child: FutureBuilder(
                      future: CustomSharedPreferences()
                          .getVoice(),
                      builder: (BuildContext context,
                          AsyncSnapshot<bool> value) {
                        return Text(AppLocalizations.of(context).translate("male"),
                            style: TextStyle(
                              color: chooseManColor(
                                  value.data == null
                                      ? true
                                      : value.data),
                              fontStyle:
                              FontStyle.normal,
                              fontSize: 20,
                              fontFamily: 'sans-serif',
                            ));
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color chooseWomanColor(bool value) {
    return value ? AppColors.TRANSPARENT_WHITE : AppColors.PINK;
  }

  Color chooseManColor(bool value) {
    return value ? AppColors.BLUE : AppColors.TRANSPARENT_WHITE;
  }
}