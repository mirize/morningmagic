import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';

class FAQScreen extends StatefulWidget {
  @override
  State createState() {
    return FAQStateScreen();
  }
}

class FAQStateScreen extends State<FAQScreen> {
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
              child: LayoutBuilder(
                builder:
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
                              top: MediaQuery.of(context).size.height / 9,
                              bottom: MediaQuery.of(context).size.height / 15,
                            ),
                            child: Text(
                              "FAQ",
                              style: TextStyle(
                                fontSize: 32,
                                fontStyle: FontStyle.normal,
                                fontFamily: "sans-serif-black",
                                color: AppColors.WHITE,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom:
                                    MediaQuery.of(context).size.height / 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                    child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "sans-serif",
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.VIOLET,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_1"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_2")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_3"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_4"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_5"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_6")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_7"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_8")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_9"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_10")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_11"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_12")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_13"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_14")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_15"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_16")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_17"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_18")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_19"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_20")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_21"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_22")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_23"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_24")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_24_a"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_24_b")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_25"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_26")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_27"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_28")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_29"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_30")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_31"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_32")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_33")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_34")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_35"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_36")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_37")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_38"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_39")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_40"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_41")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_42"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_43")),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_44"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_45"),
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate("faq_46"))
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: AnimatedButton(() {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/start', (r) => false);
                            },
                                'sans-serif',
                                AppLocalizations.of(context)
                                    .translate("back_button"),
                                19,
                                null,
                                null),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
        ),
      ),
    ));
  }

  Future<bool> _onWillPop() async {
    Navigator.pushNamedAndRemoveUntil(context, '/start', (r) => false);
    return false;
  }
}
