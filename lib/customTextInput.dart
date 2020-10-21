import 'package:flutter/material.dart';
import 'package:morningmagic/resources/colors.dart';


class CustomTextInput extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final ValueChanged onSubmitted;
  final ValueChanged onChanged;
  final IconButton suffixIcon;
  final TextEditingController controller;
  final String errorMessage;
  final String infoDescription;

  CustomTextInput(
      {@required this.hintText,
      this.isPassword = false,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.currentFocus,
      this.nextFocus,
      this.onSubmitted,
      this.suffixIcon,
      this.controller,
      this.errorMessage,
      this.infoDescription,
      @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    String tempInfoDescription = errorMessage != null ? null : infoDescription;
    String tempHintText = currentFocus.hasFocus ||
            (controller.value.text != null && controller.value.text.length == 0)
        ? hintText
        : '';
    return SizedBox(
        height: 109,
        child: Column(
          children: <Widget>[
            currentFocus.hasFocus ||
                    controller.value != null && controller.value.text.length > 0
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(hintText,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.35,
                            color: Colors.white,
                          )),
                    ))
                : new SizedBox(
                    height: 15,
                  ),
            SizedBox(height: 6),
            new TextField(
              autocorrect: false,
              enableSuggestions: false,
              minLines: 1,
              maxLines: 1,
              controller: controller,
              keyboardType: textInputType,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: textInputAction,
              obscureText: isPassword,
              focusNode: currentFocus,
              onChanged: onChanged,
              toolbarOptions: ToolbarOptions(
                cut: true,
                copy: false,
                selectAll: true,
                paste: false,
              ),
              onSubmitted: (value) {
                _fieldFocusChange(context, currentFocus, nextFocus);
              },
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Avenir',
                height: 24 / 16,
                letterSpacing: 0.35,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  hintText: currentFocus.hasFocus ? '' : tempHintText,
                  hintStyle: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    height: 24 / 16,
                    letterSpacing: 0.35,
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: errorMessage != null
                          ? AppColors.PINK
                          : AppColors.SHADER_BOTTOM,
                    ),
                  ),
                  filled: true,
                  border: new OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(6.0),
                    ),
                  ),
                  fillColor: AppColors.VIOLET,
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.PINK,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.PINK,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(
                      left: 12.0, bottom: 13.0, top: 13.0),
                  suffixIcon: suffixIcon),
            ),
            SizedBox(height: 6),
            errorMessage != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      errorMessage != null ? errorMessage : '',
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          color: AppColors.LIGHT_VIOLET,
                          fontSize: 12.0),
                    ))
                : Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            tempInfoDescription != null && currentFocus.hasFocus
                                ? tempInfoDescription
                                : '',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Avenir',
                                letterSpacing: 0.35,
                                color: Colors.white)))),
          ],
        ));
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
