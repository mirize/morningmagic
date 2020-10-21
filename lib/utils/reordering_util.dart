import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/reordering_program/order_holder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/pages/screenUpsellScreen.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:morningmagic/db/model/reordering_program/order_item.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/screenAffirmation.dart';
import 'package:morningmagic/pages/screenFitnessProgram.dart';
import 'package:morningmagic/pages/screenMeditation.dart';
import 'package:morningmagic/pages/screenReading.dart';
import 'package:morningmagic/pages/screenVizualization.dart';
import 'package:morningmagic/pages/screenVocabulary.dart';
import 'package:morningmagic/view/exerciseTile.dart';

import '../askedQuestionsScreen.dart';

class OrderUtil {
  Future<OrderHolder> getOrderHolder() async {
    OrderHolder orderHolder;
    Box box = await openMyBox();
    if (box == null) {
      box = await initAndGetBox();
      orderHolder = box.get(Resource.ORDER_PROGRAM_HOLDER,
          defaultValue: createDefaultHolder());
    } else {
      orderHolder = box.get(Resource.ORDER_PROGRAM_HOLDER,
          defaultValue: createDefaultHolder());
    }
    return orderHolder;
  }

  Future<void> saveOrderHolder(List<ExerciseTile> exerciseList) async {
    List<OrderItem> orderItemsList = List<OrderItem>();

    for (int i = 0; i < exerciseList.length; i++) {
      orderItemsList.add(OrderItem(exerciseList[i].id));
    }

    OrderHolder orderHolder = OrderHolder(orderItemsList);

    Box box = await openMyBox();

    if (box == null) {
      box = await initAndGetBox();
      box.put(Resource.ORDER_PROGRAM_HOLDER, orderHolder);
    } else {
      box.put(Resource.ORDER_PROGRAM_HOLDER, orderHolder);
    }
  }

  Future<Box> initAndGetBox() async {
    await Hive.initFlutter();
    return await Hive.openBox(Resource.BOX_NAME);
  }

  Future<Box> openMyBox() async {
    return await Hive.openBox(Resource.BOX_NAME);
  }

  OrderHolder createDefaultHolder() {
    OrderItem orderAffirmation = new OrderItem(0);
    OrderItem orderMeditation = new OrderItem(1);
    OrderItem orderFitness = new OrderItem(2);
    OrderItem orderDiary = new OrderItem(3);
    OrderItem orderReading = new OrderItem(4);
    OrderItem orderVisualization = new OrderItem(5);

    List<OrderItem> list = new List();

    list.add(orderAffirmation);
    list.add(orderMeditation);
    list.add(orderFitness);
    list.add(orderDiary);
    list.add(orderReading);
    list.add(orderVisualization);

    return new OrderHolder(list);
  }

  String getStringIdByOrderId(int id) {
    if (id == 0) {
      return "affirmation_small";
    } else if (id == 1) {
      return "meditation_small";
    } else if (id == 2) {
      return "fitness_small";
    } else if (id == 3) {
      return "diary_small";
    } else if (id == 4) {
      return "reading_small";
    } else {
      return "visualization_small";
    }
  }

  PurchaserInfo _purchaserInfo;

  Future<MaterialPageRoute> getRouteByPositionInList(int position) async {
    OrderHolder orderHolder = await getOrderHolder();

    OrderItem orderItem = orderHolder.list[position];
    int id = orderItem.position;

    await Purchases.setup("joxdRNutDmmrudomDHmIbGerKngVcZlD");
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    _purchaserInfo = purchaserInfo;
    var isPro = _purchaserInfo.entitlements.active.containsKey("all_features");

    if (isPro) {
      if (id == 0) {
        return MaterialPageRoute(builder: (context) => AffirmationScreen());
      } else if (isPro == true && id == 1) {
        return MaterialPageRoute(builder: (context) => MeditationScreen());
      } else if (isPro == true && id == 2) {
        return MaterialPageRoute(builder: (context) => FitnessProgramScreen());
      } else if (isPro == true && id == 3) {
        return MaterialPageRoute(builder: (context) => VocabularyScreen());
      } else if (isPro == true && id == 4) {
        return MaterialPageRoute(builder: (context) => ReadingScreen());
      } else {
        return MaterialPageRoute(builder: (context) => VisualizationScreen());
      }
    } else {
      if (id == 0) {
        return MaterialPageRoute(builder: (context) => AffirmationScreen());
      } else if (isPro == false && id == 1) {
        return MaterialPageRoute(builder: (context) => MeditationScreen());
      } else if (isPro == false && id == 2) {
        return MaterialPageRoute(builder: (context) => UpsellBuyScreen());
      }
    }
  }

  Future<MaterialPageRoute> getRouteById(int id) async {
    // affirmation id = 0
    // meditation id = 1
    // fitness id = 2
    // diary id = 3
    // reading = 4
    // visualization = 5

    int currentProgramPosition = await getPositionById(id);

    // increment position
    currentProgramPosition = currentProgramPosition + 1;
    if (currentProgramPosition == 6) {
      return MaterialPageRoute(builder: (context) => AskedQuestionsScreen());
    } else {
      // if currentProgramPosition < 6
      return getRouteByPositionInList(currentProgramPosition);
    }
  }

  Future<int> getPositionById(int id) async {
    OrderHolder orderHolder = await getOrderHolder();

    int position;

    for (int i = 0; i < orderHolder.list.length; i++) {
      if (orderHolder.list[i].position == id) {
        position = i;
        break;
      }
    }

    return position;
  }
}
