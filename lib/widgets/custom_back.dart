import 'package:flutter/material.dart';

import 'package:spendwise_tracker/widgets/custom_scaffold.dart';

import '../const_config/color_config.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  final bool isNavbar;
  final EdgeInsetsGeometry margin;
  const CustomBackground({
    super.key,
    required this.child,
    required this.isNavbar,
    this.margin = const EdgeInsets.only(top: 150, bottom: 60, left: 30, right: 30),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // title: 'Dashboard',
     // debugShowCheckedModeBanner: false,
      //theme: ThemeData(

      //  colorScheme: ColorScheme.fromSeed(seedColor: MyColor.gradientBackground),
       // useMaterial3: true,
      //),
    //  home: 
     body: Stack(
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
    child: child, 
    
             ),
    ],
      ),
    bottomNavigationBar: isNavbar?buildMyNavBar(context):null,
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
					Icons.add,
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