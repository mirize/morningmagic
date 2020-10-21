import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/screenSelectSequence.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';
import 'package:morningmagic/view/language_switcher.dart';

class UserDataInputScreen extends StatefulWidget {
  @override
  State createState() {
    return UserDataInputScreenState();
  }
}

class UserDataInputScreenState extends State<UserDataInputScreen> {
  TextEditingController myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 50, right: 50),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: 10,
                                        top:
                                            MediaQuery.of(context).size.height /
                                                3),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("your_name"),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: "sans-serif",
                                        fontStyle: FontStyle.normal,
                                        color: AppColors.VIOLET,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: AppColors.TRANSPARENT_WHITE,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 5),
                                        child: TextFormField(
                                          controller: myController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)
                                                  .translate("name");
                                            }
                                            return null;
                                          },
                                          minLines: 1,
                                          maxLines: 1,
                                          cursorColor: AppColors.VIOLET,
                                          keyboardType: TextInputType.text,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "sans-serif",
                                              fontStyle: FontStyle.normal,
                                              color: AppColors.VIOLET,
                                              decoration: TextDecoration.none),
                                          decoration: new InputDecoration(),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 15),
                              child: LanguageSwitcher(Alignment.center),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 18,
                                  bottom:
                                      MediaQuery.of(context).size.height / 28),
                              child: ButtonTheme(
                                minWidth: 180.0,
                                height: 50.0,
                                child: AnimatedButton(() {
                                  if (_formKey.currentState.validate()) {
                                    saveNameToBox();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectSequenceScreen()),
                                    );
                                  }
                                },
                                    'sans-serif',
                                    AppLocalizations.of(context)
                                        .translate("next_button"),
                                    null,
                                    null,
                                    null),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }

  void saveNameToBox() {
    final box = Hive.box(Resource.BOX_NAME);
    if (myController.text != null && myController.text.isNotEmpty) {
      box.put(Resource.USER_KEY, User(myController.text));
      print(myController.text);
    }
  }
}
