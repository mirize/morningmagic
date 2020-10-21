import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/toastUtils.dart';

class ExerciseTile extends StatefulWidget {
  final int id;
  final bool trues;
  final String title;
  final EdgeInsets edgeInsets;
  final TextEditingController textEditingController;

  const ExerciseTile(
      {Key key,
      @required this.id,
      @required this.trues,
      @required this.title,
      @required this.edgeInsets,
      @required this.textEditingController})
      : super(key: key);

  @override
  State createState() {
    return ExerciseTileState();
  }
}

class ExerciseTileState extends State<ExerciseTile> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.edgeInsets,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: widget.trues
              ? AppColors.TRANSPARENT_WHITE
              : AppColors.TRANSPARENTS,
          borderRadius: BorderRadius.all(Radius.circular(45)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
                child: Container(
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                      color: AppColors.VIOLET,
                      fontSize: 20,
                      fontFamily: 'sans-serif',
                      fontStyle: FontStyle.normal),
                ),
              ),
            )),
            Container(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 3, top: 3),
                    child: Text(
                      AppLocalizations.of(context).translate("min"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: "sans-serif",
                          fontStyle: FontStyle.normal,
                          color: AppColors.VIOLET,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Container(
                    width: 50,
                    padding: EdgeInsets.only(bottom: 8),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: AppColors.TRANSPARENT_WHITE,
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 3, bottom: 3, left: 15, right: 15),
                          child: TextField(
//                          validator: (value) {
//                            if (value.isEmpty) {
//                              ToastUtils.showCustomToast(context, "Пустое поле ввода");
//                              return null;
//                            } else
//                              if(int.tryParse(value) == null) {
//                              ToastUtils.showCustomToast(context, "Введите целоє число");
//                              return null;
//                            }
//                            return null;
//                          },
                            controller: widget.textEditingController,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) =>
                                FocusScope.of(context).nextFocus(),
                            minLines: 1,
                            maxLines: 1,
                            cursorColor: AppColors.VIOLET,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.left,
                            decoration: null,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "sans-serif",
                                fontStyle: FontStyle.normal,
                                color: AppColors.VIOLET,
                                decoration: TextDecoration.none),
//                          decoration: InputDecoration(
//                            border: InputBorder.none
//                          ),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
