import 'package:flutter/material.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';

class RoundedBlueButton extends StatefulWidget {
  final void Function()? onClick;
  final String label;
  final Color? forGroundColor;
  final double? height;
  final double? width;
  final double? radius;
  final bool? isFilled;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? fontSize;
  final TextStyle? textStyle;
  final IconData? iconData;

  const RoundedBlueButton(
      {Key? key,
        required this.onClick,
        required this.label,
        this.forGroundColor,
        this.backgroundColor,
        this.height,
        this.width,
        this.fontSize,
        this.radius,
        this.borderRadius,
        this.textStyle,
        this.isFilled,
        this.padding, this.iconData})
      : super(key: key);

  @override
  State<RoundedBlueButton> createState() => _RoundedBlueButton();
}

class _RoundedBlueButton extends State<RoundedBlueButton> {
  bool showFilledButton = true;

  @override
  void initState() {
    showFilledButton = widget.isFilled ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: widget.onClick,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(MyColor.lightBlue),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(3),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 11,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}