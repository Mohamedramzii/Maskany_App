// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maskany_app/presentation/views/AppLayout.dart';
// import 'package:maskany_app/presentation/views/splash_screen_view.dart';

// import '../../core/app_resources/images.dart';
// import '../../core/constants.dart';
// import '../view_model/CUBIT/cubit/internet_connectivity_cubit.dart';

// class InternetChecker extends StatelessWidget {
//   const InternetChecker({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: BlocConsumer<InternetCubit,InternetState>(
//           listener: (context, state) {
//             if (state == InternetState.gained) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Connected'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             } else if (state == InternetState.lost) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Not Connected'),
//                   backgroundColor: Colors.redAccent,
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state == InternetState.gained) {
//               // Show your information when connected
//               return const SplashScreen();
//             } else if (state == InternetState.lost) {
//               return Image.asset(Images.emptySearch);
//             } else {
//               return const Center(child: CircularProgressIndicator()); // Loading indicator
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
