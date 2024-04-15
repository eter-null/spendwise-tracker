import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';


class TextFieldWithSidebar extends StatefulWidget {
  final TextEditingController controller;
  final String fieldTitle;
  final String hintText;
  final bool needValidation;
  final String errorMessage;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Color? borderColor;
  final double? borderThickness;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final String? suffixText;
  final IconData? prefixIcon;
  final Color? backgroundColor;
  final bool? viewOnly;
  final bool? needTitle;
  final TextAlign? textAlign;
  final TextStyle? hintTextStyle;
  final TextStyle? inputTextStyle;
  final Key? itemkey;
  final TextStyle? titleStyle;
  final Widget? prefixWidget;
  final String sidebarLabel;
  final IconData? sideBarIcon;
  final List<TextInputFormatter>? inputFormatters;

  final FormFieldValidator<String>? validatorClass;

  const TextFieldWithSidebar(
      {super.key,
        required this.controller,
        required this.hintText,
        required this.needValidation,
        required this.errorMessage,
        required this.fieldTitle,
        required this.sidebarLabel,
        this.textInputAction,
        this.suffixText,
        this.backgroundColor,
        this.viewOnly,
        this.validatorClass,
        this.needTitle,
        this.textAlign,
        this.prefixIcon,
        this.itemkey,
        this.borderRadius,
        this.borderSide,
        this.borderColor,
        this.borderThickness,
        this.hintTextStyle,
        this.inputTextStyle,
        this.sideBarIcon,
        this.inputType,
        this.inputFormatters,
        this.titleStyle, this.prefixWidget});

  @override
  State<TextFieldWithSidebar> createState() => _TextFieldWithSidebar();
}

class _TextFieldWithSidebar extends State<TextFieldWithSidebar> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // if header is needed
                  if (widget.needTitle ?? true)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Text(widget.fieldTitle,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: MyColor.blueGray,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          )
                      ),
                    ),
                  if (widget.needTitle ?? true) const SizedBox(height: 5),


                  TextFormField(
                    key: widget.itemkey,
                    controller: widget.controller,
                    keyboardType: widget.inputType ?? TextInputType.number,
                    inputFormatters: widget.inputFormatters,
                    style: TextStyle(
                        fontFamily: 'Roboto'
                    ),
                    textAlign: widget.textAlign ?? TextAlign.start,
                    readOnly: widget.viewOnly ?? false,

                    // decor
                    decoration: InputDecoration(
                      errorStyle: TextDesign().bodyTextExtraSmall.copyWith(fontSize: 11, color: Colors.red),
                      hintText: widget.hintText,
                      hintStyle: widget.hintTextStyle ?? TextDesign().greyHintText,
                      filled: true,
                      fillColor: widget.backgroundColor ?? Colors.white,
                      suffixText: widget.suffixText != null ? widget.suffixText.toString() : "",
                      suffixIcon: null,
                      prefixIcon: widget.prefixWidget ?? (widget.prefixIcon != null ? Icon(widget.prefixIcon) : null),
                      border: OutlineInputBorder(borderRadius: widget.borderRadius ?? BorderRadius.circular(10), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.borderColor ?? MyColor.lightBlue,
                          width: widget.borderThickness ?? 2,
                        ),
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColor.yinminBlue,
                          width: widget.borderThickness ?? 2,
                        ),
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
                      ),
                    ),

                    // textInputAction: widget.textInputAction ?? TextInputAction.next,
                    // onFieldSubmitted: (value) {
                    //   widget.controller.text = value;
                    // },
                    // onSaved: (value) {
                    //   widget.controller.text = value!;
                    // },
                    // // validator: widget.validatorClass ?? ValidatorClass().noValidationRequired,
                    // onChanged: (value) {
                    //   if (value.isNotEmpty && widget.onValueChange != null) {
                    //     widget.onValueChange!(value);
                    //   }
                    // },
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 26, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 64,
                decoration: BoxDecoration(
                  color: MyColor.lightBlue,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: MyColor.lightBlue,
                    width: 1,
                  ),
                ),
                alignment: AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // icon
                    Visibility(
                      visible: widget.sideBarIcon != null,
                      child: Icon(
                        widget.sideBarIcon,
                        color: Colors.white,
                      ),
                    ),
                    // name
                    Visibility(
                      visible: widget.sideBarIcon == null,
                      child: Text(
                        widget.sidebarLabel,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          letterSpacing: 0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            ],
          ),
        ),
      ],
    );
  }
}