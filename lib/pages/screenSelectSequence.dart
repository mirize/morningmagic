import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/db/model/affirmation_text/affirmation_text.dart';
import 'package:morningmagic/db/model/book/book.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/user/user.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/dialog/paymentDialog.dart';
import 'package:morningmagic/pages/screenStart.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';
import 'package:morningmagic/view/language_switcher.dart';
import 'package:morningmagic/view/remove_progress.dart';
import 'package:morningmagic/view/wrapTable.dart';

class SelectSequenceScreen extends StatefulWidget {
  @override
  State createState() {
    return SelectSequenceScreenState();
  }
}

class SelectSequenceScreenState extends State<SelectSequenceScreen> {
  Box box;

  TextEditingController affirmationTimeController;
  TextEditingController meditationTimeController;
  TextEditingController fitnessTimeController;
  TextEditingController vocabularyTimeController;
  TextEditingController readingTimeController;
  TextEditingController visualizationTimeController;
  TextEditingController affirmationTextController;
  TextEditingController bookController;
  TextEditingController nameController;

  PurchaserInfo _purchaserInfo;
  Offerings _offerings;

  Future<void> initPlatformState() async {
    await Purchases.setup("joxdRNutDmmrudomDHmIbGerKngVcZlD");
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    Offerings offerings = await Purchases.getOfferings();
    if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  void initTextEditingControllers() {
    affirmationTimeController = TextEditingController(
        text: getInitialValueForTimeField(Resource.AFFIRMATION_TIME_KEY));
    meditationTimeController = TextEditingController(
        text: getInitialValueForTimeField(Resource.MEDITATION_TIME_KEY));
    fitnessTimeController = TextEditingController(
        text: getInitialValueForTimeField(Resource.FITNESS_TIME_KEY));
    vocabularyTimeController = TextEditingController(
        text: getInitialValueForTimeField(Resource.VOCABULARY_TIME_KEY));
    readingTimeController = TextEditingController(
        text: getInitialValueForTimeField(Resource.READING_TIME_KEY));
    visualizationTimeController = TextEditingController(
        text: getInitialValueForTimeField(Resource.VISUALIZATION_TIME_KEY));
    affirmationTextController =
        TextEditingController(text: getInitialValueForAffirmationTextField());

    bookController = TextEditingController(text: getInitialValueForBookField());
    nameController = TextEditingController(text: getInitialValueForNameField());
  }

  String getInitialValueForTimeField(String key) {
    String result = "3";
    ExerciseTime time = box.get(key);
    if (time != null) {
      result = time.time.toString();
    }
    return result;
  }

  void clearTextFunction(TextEditingController controller, String key) {
    if (controller.text.contains(".") ||
        controller.text.contains("-") ||
        controller.text.contains(",") ||
        controller.text.contains(" ") ||
        controller.text.length > 2 ||
        (int.tryParse(controller.text) != null &&
            int.tryParse(controller.text) < 1)) {
      print("CLEAR !!!!!!!!!!");
      controller.clear();
      controller.text = "1";
      box.put(key, ExerciseTime(1));
    }
  }

  void addListenersToEditText() {
    affirmationTimeController.addListener(() {
      clearTextFunction(
          affirmationTimeController, Resource.AFFIRMATION_TIME_KEY);
      if (affirmationTimeController.text != null &&
          affirmationTimeController.text.isNotEmpty) {
        int input = int.tryParse(affirmationTimeController.text);
        if (input != null) {
          box.put(Resource.AFFIRMATION_TIME_KEY, ExerciseTime(input));
        }
      } else {
        box.put(Resource.AFFIRMATION_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    meditationTimeController.addListener(() {
      clearTextFunction(meditationTimeController, Resource.MEDITATION_TIME_KEY);
      if (meditationTimeController.text != null &&
          meditationTimeController.text.isNotEmpty) {
        int input = int.tryParse(meditationTimeController.text);
        if (input != null) {
          box.put(Resource.MEDITATION_TIME_KEY, ExerciseTime(input));
        }
      } else {
        box.put(Resource.MEDITATION_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    fitnessTimeController.addListener(() {
      clearTextFunction(fitnessTimeController, Resource.FITNESS_TIME_KEY);
      if (fitnessTimeController.text != null &&
          fitnessTimeController.text.isNotEmpty) {
        int input = int.tryParse(fitnessTimeController.text);
        if (input != null) {
          box.put(Resource.FITNESS_TIME_KEY, ExerciseTime(input));
        }
      } else {
        box.put(Resource.FITNESS_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    vocabularyTimeController.addListener(() {
      clearTextFunction(vocabularyTimeController, Resource.VOCABULARY_TIME_KEY);
      if (vocabularyTimeController.text != null &&
          vocabularyTimeController.text.isNotEmpty) {
        int input = int.tryParse(vocabularyTimeController.text);
        if (input != null) {
          box.put(Resource.VOCABULARY_TIME_KEY, ExerciseTime(input));
        }
      } else {
        box.put(Resource.VOCABULARY_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    readingTimeController.addListener(() {
      clearTextFunction(readingTimeController, Resource.READING_TIME_KEY);
      if (readingTimeController.text != null &&
          readingTimeController.text.isNotEmpty) {
        int input = int.tryParse(readingTimeController.text);
        if (input != null) {
          box.put(Resource.READING_TIME_KEY, ExerciseTime(input));
        }
      } else {
        box.put(Resource.READING_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    visualizationTimeController.addListener(() {
      clearTextFunction(
          visualizationTimeController, Resource.VISUALIZATION_TIME_KEY);
      if (visualizationTimeController.text != null &&
          visualizationTimeController.text.isNotEmpty) {
        int input = int.tryParse(visualizationTimeController.text);
        if (input != null) {
          box.put(Resource.VISUALIZATION_TIME_KEY, ExerciseTime(input));
        }
      } else {
        box.put(Resource.VISUALIZATION_TIME_KEY, ExerciseTime(0));
      }
      setState(() {});
    });
    affirmationTextController.addListener(() {
      if (affirmationTextController.text != null &&
          affirmationTextController.text.isNotEmpty) {
        box.put(Resource.AFFIRMATION_TEXT_KEY,
            AffirmationText(affirmationTextController.text));
      }
      setState(() {});
    });

    bookController.addListener(() {
      if (bookController.text != null && bookController.text.isNotEmpty) {
        box.put(Resource.BOOK_KEY, Book(bookController.text));
      }
      setState(() {});
    });
    nameController.addListener(() {
      if (nameController.text != null && nameController.text.isNotEmpty) {
        box.put(Resource.USER_KEY, User(nameController.text));
      }
      setState(() {});
    });
  }

  Future<Box> initAndGet() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  Future<Box> openMyBox() async {
    return await Hive.openBox(Resource.BOX_NAME);
  }

  String getAndCalculateTime(Box box) {
    ExerciseTime affirmation =
        box.get(Resource.AFFIRMATION_TIME_KEY, defaultValue: ExerciseTime(3));
    int affirmation_time = affirmation.time;

    ExerciseTime meditation =
        box.get(Resource.MEDITATION_TIME_KEY, defaultValue: ExerciseTime(3));
    int meditation_time = meditation.time;

    ExerciseTime fitness =
        box.get(Resource.FITNESS_TIME_KEY, defaultValue: ExerciseTime(3));
    int fitness_time = fitness.time;

    ExerciseTime vocabulary =
        box.get(Resource.VOCABULARY_TIME_KEY, defaultValue: ExerciseTime(3));
    int vocabulary_time = vocabulary.time;

    ExerciseTime reading =
        box.get(Resource.READING_TIME_KEY, defaultValue: ExerciseTime(3));
    int reading_time = reading.time;

    ExerciseTime visualization =
        box.get(Resource.VISUALIZATION_TIME_KEY, defaultValue: ExerciseTime(3));
    int visualization_time = visualization.time;

    int sum = affirmation_time +
        meditation_time +
        fitness_time +
        vocabulary_time +
        reading_time +
        visualization_time;

    return "– " +
        sum.toString() +
        " " +
        AppLocalizations.of(context).translate("minutes");
  }

  Future<String> getSumString() async {
    box = await openMyBox();
    if (box == null) {
      box = await initAndGetBox();
      return getAndCalculateTime(box);
    } else {
      return getAndCalculateTime(box);
    }
  }

  String getInitialValueForAffirmationTextField() {
    String result = "";
    AffirmationText time = box.get(Resource.AFFIRMATION_TEXT_KEY);
    if (time != null) {
      result = time.affirmationText;
    }
    return result;
  }

  String getInitialValueForBookField() {
    String result = "";
    Book time = box.get(Resource.BOOK_KEY);
    if (time != null) {
      result = time.bookName;
    }
    return result;
  }

  String getInitialValueForNameField() {
    String result = "";
    User user = box.get(Resource.USER_KEY);
    if (user != null) {
      result = user.name;
    }
    return result;
  }

  @override
  void dispose() {
    affirmationTimeController.dispose();
    meditationTimeController.dispose();
    fitnessTimeController.dispose();
    vocabularyTimeController.dispose();
    readingTimeController.dispose();
    visualizationTimeController.dispose();

    affirmationTextController.dispose();
    bookController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    box = Hive.box(Resource.BOX_NAME);
    if (box == null) {
      openMyBox().then((value) {
        box = value;
        if (box == null) {
          initAndGetBox().then((value) {
            box = value;
            _init();
          });
        } else {
          _init();
        }
      });
    } else {
      _init();
    }
    _initOpenDialog();
    initPlatformState();
    super.initState();
  }

  void _init() {
    initTimerValue();
    initTextEditingControllers();
    addListenersToEditText();
  }

  Future<Box> initAndGetBox() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  void initTimerValue() {
    if (box.get(Resource.AFFIRMATION_TIME_KEY) == null) {
      box.put(Resource.AFFIRMATION_TIME_KEY, ExerciseTime(3));
    }
    if (box.get(Resource.MEDITATION_TIME_KEY) == null) {
      box.put(Resource.MEDITATION_TIME_KEY, ExerciseTime(3));
    }
    if (box.get(Resource.FITNESS_TIME_KEY) == null) {
      box.put(Resource.FITNESS_TIME_KEY, ExerciseTime(3));
    }
    if (box.get(Resource.VOCABULARY_TIME_KEY) == null) {
      box.put(Resource.VOCABULARY_TIME_KEY, ExerciseTime(3));
    }
    if (box.get(Resource.READING_TIME_KEY) == null) {
      box.put(Resource.READING_TIME_KEY, ExerciseTime(3));
    }
    if (box.get(Resource.VISUALIZATION_TIME_KEY) == null) {
      box.put(Resource.VISUALIZATION_TIME_KEY, ExerciseTime(3));
    }
  }

  void _initOpenDialog() async {
    await Future.delayed(Duration(seconds: 3));
    if (context != null) {
      _openDialog();
    }
  }

  void _openDialog() async {
    await Purchases.setup("joxdRNutDmmrudomDHmIbGerKngVcZlD");
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    _purchaserInfo = purchaserInfo;
    var isPro = _purchaserInfo.entitlements.active.containsKey("all_features");
    if (!isPro) {
      await showDialog(
          context: context, builder: (BuildContext context) => PaymentDialog());
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController =
        PrimaryScrollController.of(context) ?? ScrollController();

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
                  gradient: RadialGradient(
                colors: [AppColors.LIGHT_CREAM, AppColors.CREAM],
                radius: 0.6,
                center: Alignment(0.6, -0.2),
              )),
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 65),
                child: Form(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("choose"),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppColors.VIOLET,
                                    fontFamily: 'sans-serif-black',
                                    fontStyle: FontStyle.normal,
                                    fontSize: 26),
                              ),
                            )),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("choose_title"),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.VIOLET,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'sans-serif',
                                fontSize: 14),
                          ),
                        ),
                      ),
                      SliverPadding(padding: EdgeInsets.only(top: 15)),
                      WrapTable(
                        affirmationTimeController,
                        meditationTimeController,
                        fitnessTimeController,
                        vocabularyTimeController,
                        readingTimeController,
                        visualizationTimeController,
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        child: Text(
                                      AppLocalizations.of(context)
                                          .translate("duration"),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.VIOLET,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'sans-serif',
                                          fontSize: 14),
                                    )),
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate("magic_morning"),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: AppColors.VIOLET,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: 'sans-serif',
                                            fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: FutureBuilder(
                                        future: getSumString(),
                                        builder: (BuildContext buildContext,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasError) {
                                              print(snapshot.error);
                                            }
                                            return Text(
                                              snapshot.data,
                                              style: TextStyle(
                                                  color: AppColors.VIOLET,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: 'sans-serif',
                                                  fontSize: 21),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      )))
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                            padding: EdgeInsets.only(top: 15, left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("write_affirmation"),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppColors.VIOLET,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'sans-serif-black',
                                    fontSize: 26),
                              ),
                            )),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: AppColors.TRANSPARENT_WHITE,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: affirmationTextController,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (_) =>
                                      FocusScope.of(context).nextFocus(),
                                  minLines: 6,
                                  maxLines: 6,
                                  cursorColor: AppColors.VIOLET,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "sans-serif",
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.VIOLET,
                                      decoration: TextDecoration.none),
                                  decoration: InputDecoration(
                                    hintMaxLines: 8,
                                    hintText: AppLocalizations.of(context)
                                        .translate("affirmation_hint"),
                                    hintStyle: TextStyle(
                                      color: AppColors.LIGHT_GRAY,
                                      fontSize: 16,
                                      fontFamily: "sans-serif",
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              )),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, top: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("book_name"),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: AppColors.VIOLET,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'sans-serif-black',
                                  fontSize: 26),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: AppColors.TRANSPARENT_WHITE,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 11, bottom: 11, right: 20, left: 20),
                                child: TextField(
                                  controller: bookController,
                                  minLines: 1,
                                  maxLines: 1,
                                  cursorColor: AppColors.VIOLET,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: "sans-serif",
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.VIOLET,
                                      decoration: TextDecoration.none),
                                  decoration: null,
                                ),
                              )),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, top: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("enter_your_name"),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: AppColors.VIOLET,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'sans-serif-black',
                                  fontSize: 26),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: AppColors.TRANSPARENT_WHITE,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 11, bottom: 11, right: 20, left: 20),
                                child: TextField(
                                  controller: nameController,
                                  minLines: 1,
                                  maxLines: 1,
                                  cursorColor: AppColors.VIOLET,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: "sans-serif",
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.VIOLET,
                                      decoration: TextDecoration.none),
                                  decoration: null,
                                ),
                              )),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: RemoveProgress(),
                      ),
                      SliverToBoxAdapter(
                        child: LanguageSwitcher(Alignment.centerLeft),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: AnimatedButton(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartScreen()));
                          },
                              'sans-serif',
                              AppLocalizations.of(context)
                                  .translate("continue"),
                              null,
                              null,
                              null),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: load_buy(),
                        ),
                      ),
                      SliverPadding(padding: EdgeInsets.only(bottom: 20))
                    ],
                  ),
                ),
              )),
        ),
      ),
    ));
  }

  Widget load_buy() {
    if (_purchaserInfo == null) {
      return Text("null");
    } else {
      var isPro =
          _purchaserInfo.entitlements.active.containsKey("all_features");
      if (isPro) {
        return IsProScreen();
      } else {
        return UpsellScreen(
          offerings: _offerings,
        );
      }
    }
  }

  Future<bool> _onWillPop() async {
    Navigator.pushNamedAndRemoveUntil(context, '/start', (r) => false);
    return false;
  }
}

class UpsellScreen extends StatelessWidget {
  final Offerings offerings;

  UpsellScreen({Key key, @required this.offerings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (offerings != null) {
      final offering = offerings.current;
      if (offering != null) {
        final monthly = offering.monthly;
        if (monthly != null) {
          return Container(
            child: Center(
              child: PurchaseButton(package: monthly),
            ),
          );
        }
      }
    }
  }
}

class PurchaseButton extends StatelessWidget {
  final Package package;

  PurchaseButton({Key key, @required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(() async {
      try {
        PurchaserInfo purchaserInfo = await Purchases.purchasePackage(package);
        var isPro = purchaserInfo.entitlements.all["all_features"].isActive;
        if (isPro) {
          return IsProScreen();
        }
      } on PlatformException catch (e) {
        var errorCode = PurchasesErrorHelper.getErrorCode(e);
        if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
          print("User cancelled");
        } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
          print("User not allowed to purchase");
        }
      }
    }, 'sans-serif', AppLocalizations.of(context).translate("pay"), null, null,
        null);
  }
}

class IsProScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          AppLocalizations.of(context).translate("user_is_pro"),
        ),
      ),
    );
  }
}
