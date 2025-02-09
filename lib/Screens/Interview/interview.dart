import 'package:flutter/material.dart';
import 'package:grem/Components/widget_extensions.dart';
import 'package:grem/Widgets/button.dart';
import 'package:grem/Widgets/toast.dart';
import 'package:grem/Widgets/url_laucher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/color.dart';
import '../../Constants/paths.dart';
import '../../Constants/sizedbox.dart';
import '../../Constants/textStyle.dart';
import '../../Widgets/appbar.dart';
import '../../Widgets/textfield.dart';
import '../quest_completion_screen.dart';


class InterviewScreen extends StatefulWidget {
  const InterviewScreen({Key? key}) : super(key: key);

  @override
  _InterviewScreenState createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  final List<String> _questions = [
    "What are the primary business objectives?",
    "What are the pain points in the current system?",
    "How should the solution prioritize scalability vs cost?",
  ];
  int _currentQuestionIndex = 0;
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      resizeToAvoidBottomInset: false,
      appBar: appBar(title: 'Interview Session'),
      body: Padding(
        padding: kPaddingHorizontal20,
        child: Column(
          children: [
            // Progress Indicator
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _questions.length,
              color: mainColor,
            ),
            sizeHeight30,

            // Current Question
            Text(
              _questions[_currentQuestionIndex],
              style: txtStyle18AndBold,
              textAlign: TextAlign.center,
            ),
            sizeHeight30,

            // Notes Field
            Form(
              key: _formKey,
              child: CustomTextField(
                hintText: 'Add notes...',
                maxLine: 10,
                controller: controller,
                validator: (value) =>
                (value == null || value.trim().isEmpty) ? "Notes is required" : null,
              ),
            ),
            sizeHeight20,
            _currentQuestionIndex < _questions.length - 1 ? SizedBox() :
            // Video Call & Navigation
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton.icon(
                // onPressed: () => _launchVideoCall('googlemeet'),
                onPressed: (){
                  launchVideoCall("googlemeet");
                },
                icon: const Icon(Icons.video_call,color: whiteColor,),
                label: Text('Join Zoom Meet', style: txtStyle14AndWhiteBold),
                style: ElevatedButton.styleFrom(
                    backgroundColor: redColor,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 48),

                ),
              ),
            ),
            _currentQuestionIndex < _questions.length - 1 ? SizedBox() :

            sizeHeight20,
            MyButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
                if (_currentQuestionIndex < _questions.length - 1) {
                  setState(() {

                    controller.clear();
                    _currentQuestionIndex++;
                  });
                } else {
                  QuestCompletionScreen().launch(context);
                  // Navigator.pop(context);
                }
                }
              },
             text:
                _currentQuestionIndex < _questions.length - 1 ? 'Next' : 'Finish',
            ),
            sizeHeight20,
          ],
        ),
      ),
    );
  }

}
  void launchVideoCall(String platform) async {
    const meetUrl = zoomMeet;
    const zoomUrl = zoomMeet;
    // final url = platform == 'googlemeet' ? meetUrl : zoomUrl;

    launchURL(url: zoomMeet,launchMode: LaunchMode.externalApplication);
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   AppToast.show('Could not launch $url');
    // }
  }
