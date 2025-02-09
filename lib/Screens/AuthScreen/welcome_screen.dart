//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:grem/Components/widget_extensions.dart';
// import '../../Constants/color.dart';
// import '../../Constants/paths.dart';
// import '../../Constants/sizedbox.dart';
// import '../../Widgets/button.dart';
// import '../../utils/app_common.dart';
// import 'EmailPassword/email_password.dart';
// import 'Login/login_with_email.dart';
//
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Container(
//           padding: kDefaultPaddingHorizontal,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 18),
//
//               Expanded(
//                 child:
//                 // Image.asset(
//                 //   onBoardingImage,
//                 //   fit: BoxFit.contain,
//                 // ),
//                 cachedImage(onBoardingImage,),
//               ),
//               const SizedBox(height: 42),
//               Text(
//                 'Connect easily with your family and friends over countries',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                   fontWeight: FontWeight.w700,
//                   color: const Color(0xFF0F1828),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 54),
//               Text(
//                 'Terms & Privacy Policy',
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   color: const Color(0xFF0F1828),
//                 ),
//               ),
//               const SizedBox(height: 23),
//               MyButton(
//                 text: 'Continue with email',
//                 backgroundColor: mainColor,
//                 onPressed: () {EmailPasswordScreen().launch(context);},
//               ),
//               const SizedBox(height: 9),
//               MyButton(
//                 text: 'Continue with phone',
//                 backgroundColor: textColor,
//                 onPressed: () {
//                   // PhoneScreen().launch(context);
//                 },
//               ),
//               const SizedBox(height: 9),
//               MyButton(
//                 text: 'Login',
//                 backgroundColor: Colors.transparent,
//                 textColor: mainColor,
//                 onPressed: () {
//                   // pop(context);
//                   LoginWithEmailPassword().launch(context);
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
//                 },
//               ),
//               const SizedBox(height: 13),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }