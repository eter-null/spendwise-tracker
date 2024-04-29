import 'package:flutter/material.dart';

import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../../services/utils/validator.dart';


class BlueBorderPasswordTextField extends StatefulWidget {
  final TextEditingController password;
  final String? fieldTitle;
  final String hintText;
  final Color? backgroundColor;
  final TextInputAction? textInputAction;
  final String? errorMessage;
  final double? borderThickness;
  final BorderRadius? borderRadius;
  final Color? borderColor;




  const BlueBorderPasswordTextField({
    Key? key,
    required this.password,
    this.fieldTitle,
    required this.hintText,
    this.textInputAction,
    this.backgroundColor,
    this.errorMessage,
    this.borderThickness,
    this.borderRadius,
    this.borderColor,
  }) : super(key: key);

  @override
  State<BlueBorderPasswordTextField> createState() => _BlueBorderPasswordTextField();
}

class _BlueBorderPasswordTextField extends State<BlueBorderPasswordTextField> {

  bool hidePassword = true;
  bool hasSomePassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if header is needed
        if (widget.fieldTitle != null)
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Text(widget.fieldTitle!,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: MyColor.blueGray,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                )
            ),
          ),
        if (widget.fieldTitle != null) const SizedBox(height: 5),
        TextFormField(
          autofocus: false,
          obscureText: hidePassword,
          controller: widget.password,
          onFieldSubmitted: (value) {
            widget.password.text = value;
          },
          onChanged: (value) {
            if (widget.password.text.isNotEmpty) {
              setState(() {
                hasSomePassword = true;
              });
            } else {
              setState(() {
                hasSomePassword = false;
              });
            }
          },
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          validator: ValidatorClass().validatePassword,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            focusColor: MyColor.yinminBlue,
            filled: true,
            fillColor: widget.backgroundColor ?? Colors.white,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              icon: !hidePassword ? const Icon(Icons.lock_open_outlined, color: MyColor.lightBlue) : const Icon(Icons.lock, color: MyColor.lightBlue),
            ),
            hintText: widget.hintText,
            hintStyle: TextDesign().greyHintText,
            errorStyle: TextDesign().bodyTextExtraSmall.copyWith(fontSize: 11, color: Colors.red),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyColor.yinminBlue,
                width: widget.borderThickness ?? 2,
              ),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
            ),
            border: OutlineInputBorder(borderRadius: widget.borderRadius ?? BorderRadius.circular(10), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? MyColor.powderBlue,
                width: widget.borderThickness ?? 2,
              ),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: widget.borderThickness ?? 2,
              ),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: widget.borderThickness ?? 2,
              ),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
