import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/screenSelectSequence.dart';
import 'package:morningmagic/pages/screenStart.dart';
import 'package:morningmagic/pages/screenUserDataInput.dart';
import 'package:morningmagic/main.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/shared_preferences.dart';

class InitialScreen extends StatefulWidget {
  @override
  InitialScreenState createState() {
    return InitialScreenState();
  }
}

class InitialScreenState extends State<InitialScreen>
    with SingleTickerProviderStateMixin {
  Box box;
  AnimationController controller;
  Animation<double> animation;
  bool switcherRay = false;
  bool switcherSun = false;
  bool firstBuild = false;

  @override
  void initState() {
    CustomSharedPreferences().getLanguage().then((value) {
      if (value != null) {
        if (value) {
          Locale newLocale = Locale('en', 'US');
          MyApp.setLocale(context, newLocale);
        } else {
          Locale newLocale = Locale('ru', 'RU');
          MyApp.setLocale(context, newLocale);
        }
      }
    });

    initAndGetBox().then((value) {
      box = value;
      _initRedirect();
    });

    controller = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        switcherRay = true;
      }
    });
    animation = Tween<double>(begin: 1, end: 0.3).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  Future<Box> initAndGetBox() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!firstBuild) {
      Future.delayed(const Duration(milliseconds: 500), () {
        controller.forward();
        switcherSun = true;
      });

      firstBuild = true;
    }
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sky.png'),
                    fit: BoxFit.cover),
              ),
              child: Visibility(
                visible: switcherSun,
                child: Align(
                  alignment: Alignment(0, -0.3),
                  child: getNameWidget(),
                ),
              )),
          Visibility(
            visible: switcherSun,
            child: Container(
              child: Align(
                alignment: Alignment(-0.05, animation.value),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/clear_sun.png'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/mountains.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Visibility(
            visible: switcherRay,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/sun_rays.png'),
                fit: BoxFit.cover,
              )),
            ),
          ),
        ],
      )),
    );
  }

  void _initRedirect() async {
    await Future.delayed(Duration(seconds: 4));
    _openScreen();
  }

  void _openScreen() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => chooseNavigationWidget()),
    );
  }

  Widget chooseNavigationWidget() {
    if (box.get(Resource.USER_KEY) != null) {
      return chooseSettingsOrStartMenu();
    } else {
      return UserDataInputScreen();
    }
  }

  Widget chooseSettingsOrStartMenu() {
    if (box.get(Resource.BOOK_KEY) != null &&
        box.get(Resource.AFFIRMATION_TEXT_KEY) != null) {
      return StartScreen();
    } else {
      return SelectSequenceScreen();
    }
  }

  Widget getNameWidget() {
    return FutureBuilder(
      future: getBox(),
      builder: (BuildContext context, AsyncSnapshot<Box> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          box = snapshot.data;
          User user = box.get(Resource.USER_KEY);
          String text;
          if (user != null) {
            text = user.name;
            return Text(
              getUserNameSentence(text),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.WHITE,
                fontFamily: 'rex',
                fontSize: 26,
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Future<Box> getBox() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  String getUserNameSentence(String name) {
    return AppLocalizations.of(context).translate("good_morning") + name + "!";
  }
}
