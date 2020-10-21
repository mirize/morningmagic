import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morningmagic/dialog/deleteProgressDialog.dart';
import 'package:morningmagic/resources/colors.dart';

import '../appLocalization.dart';

class RemoveProgress extends StatefulWidget {
  @override
  State createState() {
    return RemoveProgressState();
  }
}

class RemoveProgressState extends State<RemoveProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context).translate("remove_progress"),
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
          padding: EdgeInsets.only(top: 15),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => DeleteProgressDialog(() {
                        setState(() {});
                      }));
            },
            child: Container(
              width: 45,
              height: 45,
              child: SvgPicture.asset("assets/svg/trash.svg",
                  color: AppColors.WHITE),
            ),
          ),
        )
      ],
    );
  }
}
