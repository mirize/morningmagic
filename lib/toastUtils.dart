import 'dart:async';
import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/view/tastMessageAnimation.dart';


class ToastUtils {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

  static void showCustomToast(BuildContext context, String message) {
    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(Duration(seconds: 1), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }
  }

  static OverlayEntry createOverlayEntry(BuildContext context, String message) {
    return OverlayEntry(
        builder: (context) => Positioned(
              top: 52,
              width: MediaQuery.of(context).size.width - 20,
              left: 10,
              child: ToastMessageAnimation(Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                      color: AppColors.PINK,
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
            ));
  }
}
