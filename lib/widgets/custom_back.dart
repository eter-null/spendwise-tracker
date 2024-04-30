import 'package:flutter/material.dart';
import 'package:spendwise_tracker/widgets/custom_scaffold.dart';

import '../const_config/color_config.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  const CustomBackground({super.key, required this.child,
    this.margin = const EdgeInsets.only(top: 150, bottom: 100, left: 30, right: 30),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: MyColor.gradientBackground),
        useMaterial3: true,
      ),
      home: Stack(
        children: [
            const ScaffoldWithBackground(),
            Container(
              alignment: Alignment.center,
              height:MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10.0),

              margin: margin,
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              // child: child,
  //   child: Row( 
	// 	mainAxisAlignment: MainAxisAlignment.spaceAround, 
	// 	children: [ 
    
	// 	IconButton( 
	// 		enableFeedback: false, 
	// 		onPressed: () { 
			 
	// 		}, 
	// 		icon: const Icon( 
	// 				Icons.home_filled, 
	// 				color: Colors.white, 
	// 				size: 35, 
	// 			)  
	// 	), 
	// 	IconButton( 
	// 		enableFeedback: false, 
	// 		onPressed: () { 
			 
	// 		}, 
	// 		icon: const Icon( 
	// 				Icons.work_rounded, 
	// 				color: Colors.white, 
	// 				size: 35, 
	// 			) 

	// 	),
	// 	IconButton(
	// 			enableFeedback: false,
	// 			onPressed: () {


	// 			},
	// 			icon: const Icon(
	// 				Icons.add,
	// 				color: Colors.white,
	// 				size: 35,
	// 			)
	// 	),
	// 	IconButton(
	// 	enableFeedback: false,
	// 	onPressed: () {


	// 	},
	// 	icon: const Icon(
	// 			Icons.widgets_rounded,
	// 			color: Colors.white,
	// 			size: 35,
	// 		)
	// ),
	// 	IconButton( 
	// 		enableFeedback: false, 
	// 		onPressed: () { 
			
	// 		}, 
	// 		icon: const Icon( 
	// 				Icons.person, 
	// 				color: Colors.white, 
	// 				size: 35, 
	// 			) 

	// 	), 
	// 	], 
	// ), 
             ),
    ],
      ),
    );
  }
}