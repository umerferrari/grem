import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grem/Components/common.dart';
import 'package:grem/Components/widget_extensions.dart';
import 'package:grem/Screens/BottomBar/bottom_bar.dart';
import 'package:grem/Widgets/dialogBox.dart';
import '../Constants/color.dart';
import '../Constants/paths.dart';
import '../Constants/sizedbox.dart';
import '../Constants/textStyle.dart';
import '../Widgets/appbar.dart';
import '../Widgets/button.dart';
import '../Widgets/toast.dart';
import 'Interview/interview.dart';
import 'requirement_elication_screen.dart';

class QuestCompletionScreen extends StatefulWidget {
  const QuestCompletionScreen({super.key});

  @override
  State<QuestCompletionScreen> createState() => _QuestCompletionScreenState();
}

class _QuestCompletionScreenState extends State<QuestCompletionScreen> {
  int _xpPoints = 0;
  int _correctAnswers = 0;
  int _level = 0;
  int _currentQuestionIndex = 0;
  bool? _selectedAnswer;

  final List<Map<String, dynamic>> _questQuestions = [
    {"question": "Does the requirement align with business goals?", "answer": true},
    {"question": "Is the requirement technically feasible?", "answer": true},
    {"question": "Is the requirement documented properly?", "answer": true},
    {"question": "Are all stakeholders involved in the requirement process?", "answer": true},
  ];

  void _answerQuestion() {
    if (_selectedAnswer == null) return; // Ensure an answer is selected

    if (_questQuestions[_currentQuestionIndex]['answer'] == _selectedAnswer) {
      _correctAnswers++;
      _xpPoints += 50; // Each correct answer gives 50 XP
    }

    // Check if user has unlocked a level
    if (_correctAnswers == 2) _level = 1;
    if (_correctAnswers == 4) _level = 2;

    if (_currentQuestionIndex < _questQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null; // Reset selection for next question
      });
    } else {
      _completeQuest();
    }
  }

  void _completeQuest() {
   return dialogBox(
      context: context,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                Text("Level: $_level",style: txtStyle16AndBold,),
                IconButton(
                    onPressed: (){pop();},
                    icon: Icon(Icons.close,weight: 24,)),
              ],
            ),
            sizeHeight20,
            Center(child: Image.asset(rewardGif,height: 120,)),
            sizeHeight15,
            Text("Points Earn: $_xpPoints",textAlign: TextAlign.start,style: txtStyle14AndBold,),
            _level >= 1?
                sizeHeight5 : SizedBox(),
            _level >= 1?
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox.shrink(),
                  Flexible(
                    child: Row(
                      children: [
                        Text("Badge Earn:",style: txtStyle14AndBold,),
                        sizeWidth15,
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 8,childAspectRatio: 1.2,mainAxisSpacing: 4.0,crossAxisSpacing: 0),
                              itemCount: _level,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (c,index){
                            return CircleAvatar(
                              radius: 8,
                              backgroundColor: mainColor,
                              child: Text("${index+1}",style: txtStyle12AndWhiteBold,),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
            ) : SizedBox(),

            sizeHeight15,
            MyButton(
                onPressed: (){
                  // InterviewScreen().launch(context,);
                  BottomBar().launch(context,isNewTask: true);
                },
              text: "Continue",
            ),
          ],
        ),
      )
    );
    // AppToast.show("Quest Completed! Level $_level Unlocked!");
    // Navigator.push(context, MaterialPageRoute(builder: (context) => RequirementElicitationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Quest Completion"),
      body: Padding(
        padding: kDefaultPaddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _questQuestions.length,
              color: mainColor,
            ),
            sizeHeight20,
            Text("Solve Quest to Achieve RT", style: txtStyle18AndBold),
            sizeHeight10,
            Text("Answer the questions correctly to unlock levels!", style: txtStyle14AndBlack),
            sizeHeight30,
            Text(_questQuestions[_currentQuestionIndex]['question'], style: txtStyle16AndBold, textAlign: TextAlign.start),
            sizeHeight10,

            // Radio Buttons
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<bool>(
                  title: Text("True", style: txtStyle14AndBlack),
                  value: true,
                  activeColor: mainColor,
                  groupValue: _selectedAnswer,
                  onChanged: (value) {
                    setState(() {
                      _selectedAnswer = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(vertical: -4),
                ),
                RadioListTile<bool>(
                  title: Text("False", style: txtStyle14AndBlack),
                  value: false,
                  activeColor: mainColor,
                  groupValue: _selectedAnswer,
                  onChanged: (value) {
                    setState(() {
                      _selectedAnswer = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(vertical: -4),
                ),
              ],
            ),

            sizeHeight30,
            MyButton(
              text: _currentQuestionIndex == _questQuestions.length - 1 ? "Complete Quest 🎉" : "Next Question",
              onPressed: _selectedAnswer != null ? _answerQuestion : (){}, // Disabled if no selection
            ),
            sizeHeight30,
            Text("Your Rewards:", style: txtStyle16AndBold),
            sizeHeight10,
            Text("XP Points: $_xpPoints", style: txtStyle14AndBlack),
            // Text("Level: $_level", style: txtStyle14AndBlack),
            sizeHeight30,
          ],
        ),
      ),
    );
  }
}
