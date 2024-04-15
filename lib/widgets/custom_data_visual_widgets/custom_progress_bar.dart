import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class ProgressBar extends StatefulWidget {
  final double? startAmount;
  final double? endAmount;

  const ProgressBar(
      {super.key,
        required this.startAmount,
        required this.endAmount});

  @override
  State<ProgressBar> createState() => _ProgressBar();
}


class _ProgressBar extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {

    // handle infinity for progress bar
    double percentValue;
    if (widget.endAmount == 0) {
      percentValue = 0.0;
    } else if ((widget.endAmount ?? 0.0) <= (widget.startAmount ?? 0.0)) {
      percentValue = 1.0;
    } else {
      percentValue = (widget.startAmount! / widget.endAmount!); // Calculate percent normally
    }


    return Column(
      children: [
        LinearPercentIndicator(
          animation: true,
          lineHeight: 20.0,
          animationDuration: 500,
          percent: percentValue,
          progressColor: Color(0xFF83C2F8),
          backgroundColor: Color(0xFFCBE0F8),

        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Text(
                widget.startAmount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF72B4EC),
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
              child: Text(
                widget.endAmount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF72B4EC),
                  fontFamily: 'Roboto',
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}