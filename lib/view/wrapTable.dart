import 'package:flutter/cupertino.dart';
import 'package:morningmagic/db/model/reordering_program/order_item.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:reorderables/reorderables.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../appLocalization.dart';
import 'exerciseTile.dart';

class WrapTable extends StatefulWidget {
  final TextEditingController affirmationTimeController;
  final TextEditingController meditationTimeController;
  final TextEditingController fitnessTimeController;
  final TextEditingController vocabularyTimeController;
  final TextEditingController readingTimeController;
  final TextEditingController visualizationTimeController;

  WrapTable(
      this.affirmationTimeController,
      this.meditationTimeController,
      this.fitnessTimeController,
      this.vocabularyTimeController,
      this.readingTimeController,
      this.visualizationTimeController);

  @override
  State createState() {
    return WrapTableState();
  }
}

class WrapTableState extends State<WrapTable> {
  List<ExerciseTile> _itemRows = List();

//  bool firstBuild = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  PurchaserInfo _purchaserInfo;

  Future<void> initPlatformState() async {
    await Purchases.setup("joxdRNutDmmrudomDHmIbGerKngVcZlD");
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
    });
  }

  List<ExerciseTile> createListOfWidgets(List<OrderItem> orderItemsList) {
    List<ExerciseTile> list = new List<ExerciseTile>();

    list.add(ExerciseTile(
      key: ValueKey(1),
      id: orderItemsList[0].position,
      trues: true,
      title: AppLocalizations.of(context).translate(
          OrderUtil().getStringIdByOrderId(orderItemsList[0].position)),
      edgeInsets: EdgeInsets.only(bottom: 15),
      textEditingController: getControllerById(orderItemsList[0].position),
    ));

    list.add(ExerciseTile(
      key: ValueKey(2),
      id: orderItemsList[1].position,
      trues: true,
      title: AppLocalizations.of(context).translate(
          OrderUtil().getStringIdByOrderId(orderItemsList[1].position)),
      edgeInsets: EdgeInsets.only(bottom: 15),
      textEditingController: getControllerById(orderItemsList[1].position),
    ));
    var isPro = _purchaserInfo.entitlements.active.containsKey("all_features");
    if (isPro) {
      list.add(ExerciseTile(
        key: ValueKey(3),
        id: orderItemsList[2].position,
        trues: true,
        title: AppLocalizations.of(context).translate(
            OrderUtil().getStringIdByOrderId(orderItemsList[2].position)),
        edgeInsets: EdgeInsets.only(bottom: 15),
        textEditingController: getControllerById(orderItemsList[2].position),
      ));
      list.add(ExerciseTile(
        key: ValueKey(4),
        id: orderItemsList[3].position,
        trues: true,
        title: AppLocalizations.of(context).translate(
            OrderUtil().getStringIdByOrderId(orderItemsList[3].position)),
        edgeInsets: EdgeInsets.only(bottom: 15),
        textEditingController: getControllerById(orderItemsList[3].position),
      ));
      list.add(ExerciseTile(
        key: ValueKey(5),
        id: orderItemsList[4].position,
        trues: true,
        title: AppLocalizations.of(context).translate(
            OrderUtil().getStringIdByOrderId(orderItemsList[4].position)),
        edgeInsets: EdgeInsets.only(bottom: 15),
        textEditingController: getControllerById(orderItemsList[4].position),
      ));
      list.add(ExerciseTile(
        key: ValueKey(6),
        id: orderItemsList[5].position,
        trues: true,
        title: AppLocalizations.of(context).translate(
            OrderUtil().getStringIdByOrderId(orderItemsList[5].position)),
        edgeInsets: EdgeInsets.only(bottom: 15),
        textEditingController: getControllerById(orderItemsList[5].position),
      ));
    } else {
      list.add(ExerciseTile(
        key: ValueKey(3),
        id: orderItemsList[2].position,
        trues: false,
        title: AppLocalizations.of(context).translate(
            OrderUtil().getStringIdByOrderId(orderItemsList[2].position)),
        edgeInsets: EdgeInsets.only(bottom: 15),
        textEditingController: getControllerById(orderItemsList[2].position),
      ));
      list.add(ExerciseTile(
        key: ValueKey(4),
        id: orderItemsList[3].position,
        trues: false,
        title: AppLocalizations.of(context).translate(
            OrderUtil().getStringIdByOrderId(orderItemsList[3].position)),
        edgeInsets: EdgeInsets.only(bottom: 15),
        textEditingController: getControllerById(orderItemsList[3].position),
      ));
      list.add(ExerciseTile(
        key: ValueKey(5),
        id: orderItemsList[4].position,
        trues: false,
        title: AppLocalizations.of(context).translate(
            OrderUtil().getStringIdByOrderId(orderItemsList[4].position)),
        edgeInsets: EdgeInsets.only(bottom: 15),
        textEditingController: getControllerById(orderItemsList[4].position),
      ));
      list.add(ExerciseTile(
        key: ValueKey(6),
        id: orderItemsList[5].position,
        trues: false,
        title: AppLocalizations.of(context).translate(
            OrderUtil().getStringIdByOrderId(orderItemsList[5].position)),
        edgeInsets: EdgeInsets.only(bottom: 15),
        textEditingController: getControllerById(orderItemsList[5].position),
      ));
    }

    return list;
  }

  TextEditingController getControllerById(int id) {
    if (id == 0) {
      return widget.affirmationTimeController;
    } else if (id == 1) {
      return widget.meditationTimeController;
    } else if (id == 2) {
      return widget.fitnessTimeController;
    } else if (id == 3) {
      return widget.vocabularyTimeController;
    } else if (id == 4) {
      return widget.readingTimeController;
    } else {
      return widget.visualizationTimeController;
    }
  }

  @override
  Widget build(BuildContext context) {
//    if (!firstBuild) {
//      OrderUtil().getOrderHolder().then((value) {
//        _itemRows = createListOfWidgets(value.list);
//        setState(() {
//          firstBuild = true;
//        });
//      });
//    }
    OrderUtil().getOrderHolder().then((value) {
      _itemRows = createListOfWidgets(value.list);
      setState(() {});
    });

    return ReorderableSliverList(
      delegate: ReorderableSliverChildListDelegate(_itemRows),
      onReorder: _onReorder,
    );
  }

  List<OrderItem> reGenerateList(List<ExerciseTile> exerciseList) {
    List<OrderItem> orderItemsList = List<OrderItem>();

    for (int i = 0; i < exerciseList.length; i++) {
      orderItemsList.add(OrderItem(exerciseList[i].id));
    }

    return orderItemsList;
  }

  void _onReorder(int oldIndex, int newIndex) {
    var isPro = _purchaserInfo.entitlements.active.containsKey("all_features");

    if (isPro) {
      setState(() {
        Widget row = _itemRows.removeAt(oldIndex);
        _itemRows.insert(newIndex, row);
      });

      OrderUtil().saveOrderHolder(_itemRows).then((value) {
        print("REORDERING SAVED !!!");
      });
    } else {
      setState(() {
        Widget row = _itemRows.removeAt(oldIndex);
      });
    }
  }
}
