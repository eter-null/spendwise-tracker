import 'package:flutter/material.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';


class LabelAmountBox extends StatefulWidget {
  final String label;
  final double? amount;

  const LabelAmountBox(
      {super.key,
        required this.label,
        required this.amount});

  @override
  State<LabelAmountBox> createState() => _LabelAmountBox();
}


class _LabelAmountBox extends State<LabelAmountBox> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: MyColor.lightBlue,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: MyColor.lightBlue,
                    width: 1,
                  ),
                ),
                alignment: AlignmentDirectional(0, 0),
                child: Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                    child: Text(
                      widget.label,
                      style:
                      TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        letterSpacing: 0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xFF83C2F8),
                  width: 1,
                ),
              ),
              alignment: AlignmentDirectional(0, 0),
              child: Text(
                'BDT ${widget.amount.toString()}',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFF83C2F8),
                  fontFamily: 'Roboto',
                  letterSpacing: 0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}