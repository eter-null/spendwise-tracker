import 'package:flutter/material.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageView extends StatefulWidget {
  final List<Widget> children;
  PageController controller = PageController();


  CustomPageView({
    Key? key,
    required this.children,
    required this.controller
  }) : super(key: key);

  @override
  State<CustomPageView> createState() => _CustomPageView();
}


class _CustomPageView extends State<CustomPageView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: PageView(
              controller: widget.controller,
              children: widget.children,
            ),
        ),
        SmoothPageIndicator(
            controller: widget.controller,  // PageController
            count:  2,
            effect:  WormEffect(
              type: WormType.thin,
              dotColor: MyColor.uranianBlue,
              activeDotColor: MyColor.skyBlue,
              spacing:  20.0,
              dotWidth:  10.0,
              dotHeight:  10.0,

            ),
            onDotClicked: (index){}
        )
      ],
    )
    ;
  }
}