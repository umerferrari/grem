// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:grem/Constants/color.dart';
// import 'package:grem/Constants/sizedbox.dart';
// import 'package:grem/Constants/textStyle.dart';
// import 'package:grem/Widgets/appbar.dart';
// import 'package:grem/Widgets/textfield.dart';
//
// class InterviewScreen extends StatefulWidget {
//   const InterviewScreen({super.key});
//
//   @override
//   _InterviewScreenState createState() => _InterviewScreenState();
// }
//
// class _InterviewScreenState extends State<InterviewScreen> {
//   final List<String> _questions = [
//     "What are the primary business objectives?",
//     "What are the pain points in the current system?",
//     "How should the solution prioritize scalability vs cost?",
//   ];
//   int _currentQuestionIndex = 0;
//   final TextEditingController _notesController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(title: 'Interview Session'),
//       body: Padding(
//         padding: kDefaultPaddingHorizontal,
//         child: Column(
//           children: [
//             // Progress Indicator
//             LinearProgressIndicator(
//               value: (_currentQuestionIndex + 1) / _questions.length,
//               color: mainColor,
//             ),
//             sizeHeight30,
//
//             // Current Question
//             Text(
//               _questions[_currentQuestionIndex],
//               style: txtStyle18AndBold,
//               textAlign: TextAlign.center,
//             ),
//             sizeHeight30,
//
//             // Notes Field
//             Expanded(
//               child: CustomTextField(
//                 hintText: 'Add notes...',
//                 controller: _notesController,
//                 maxLine: 10,
//               ),
//             ),
//             sizeHeight20,
//
//             // Video Call & Navigation
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () => _launchVideoCall('googlemeet'),
//                   icon: const Icon(Icons.video_call),
//                   label: Text('Join Google Meet', style: txtStyle14AndWhiteBold),
//                   style: ElevatedButton.styleFrom(backgroundColor: redColor),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_currentQuestionIndex < _questions.length - 1) {
//                       setState(() => _currentQuestionIndex++);
//                       _notesController.clear(); // Clear notes for next question
//                     } else {
//                       Navigator.pop(context); // Return to previous screen
//                     }
//                   },
//                   child: Text(
//                     _currentQuestionIndex < _questions.length - 1 ? 'Next' : 'Finish',
//                     style: txtStyle16AndWhiteBold,
//                   ),
//                 ),
//               ],
//             ),
//             sizeHeight20,
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _launchVideoCall(String platform) async {
//     const meetUrl = 'https://meet.google.com/abc-xyz';
//     const zoomUrl = 'https://zoom.us/j/123456';
//     final url = platform == 'googlemeet' ? meetUrl : zoomUrl;
//
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Could not launch $url')),
//       );
//     }
//   }
// }