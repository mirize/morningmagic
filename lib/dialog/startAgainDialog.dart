import 'package:flutter/material.dart';
import 'package:morningmagic/appLocalization.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/animatedButton.dart';

class StartAgainDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.6,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("sure"),
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'rex',
                        fontStyle: FontStyle.normal,
                        color: AppColors.VIOLET),
                  ),
                ),
              ),
//              Container(
//                padding: EdgeInsets.only(top: 20),
//                child: Center(
//                    child: AnimatedButton(
//                          () {
//                        Navigator.pushNamedAndRemoveUntil(context, '/start', (r) => false);
//                      }, 'rex', AppLocalizations.of(context).translate("restart"), 23, null, null
//                    ),
//                ),
//              ),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  child: AnimatedButton(
                  () {
                        Navigator.pop(context, true);
                      }, 'rex', AppLocalizations.of(context).translate("cancel"), 22, null, null
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
