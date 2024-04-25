import 'package:flutter/material.dart';
import 'package:spendwise_tracker/const_config/color_config.dart';

class ScaffoldWithBackground extends StatelessWidget {
  //final Widget child; , required this.child}
  const ScaffoldWithBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.fadedBackground,
      body: Column(
      //Stack(
    children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            //color: MyColor.gradientBackground,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF78BFFC), Color(0xFF254662)],
                stops: [0, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
            ),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   // height: 300,
          //   color: MyColor.fadedBackground,
          // ),
        ],
 // ),
      ),
      bottomNavigationBar: buildMyNavBar(context),
    );
  }
}
Container buildMyNavBar(BuildContext context) { 
	return Container( 
	height: 60, 
	decoration: BoxDecoration( 
		color: MyColor.blueFadedBackground, 
		borderRadius: const BorderRadius.only( 
		topLeft: Radius.circular(20), 
		topRight: Radius.circular(20), 
		), 
	), 
	child: Row( 
		mainAxisAlignment: MainAxisAlignment.spaceAround, 
		children: [ 
		IconButton( 
			enableFeedback: false, 
			onPressed: () { 
			 
			}, 
			icon: const Icon( 
					Icons.home_filled, 
					color: Colors.white, 
					size: 35, 
				)  
		), 
		IconButton( 
			enableFeedback: false, 
			onPressed: () { 
			 
			}, 
			icon: const Icon( 
					Icons.work_rounded, 
					color: Colors.white, 
					size: 35, 
				) 

		), 
		IconButton( 
			enableFeedback: false, 
			onPressed: () { 
			
			 
			}, 
			icon: const Icon( 
					Icons.widgets_rounded, 
					color: Colors.white, 
					size: 35, 
				) 
		), 
		IconButton( 
			enableFeedback: false, 
			onPressed: () { 
			
			}, 
			icon: const Icon( 
					Icons.person, 
					color: Colors.white, 
					size: 35, 
				) 

		), 
		], 
	), 
	); 
}