import 'package:flutter/material.dart';
import '../Constants/sizedbox.dart';
import '../Constants/textStyle.dart';
import '../Widgets/appbar.dart';
import '../Widgets/button.dart';
import '../Widgets/textfield.dart';
import 'Interview/interview.dart';
import 'brain_storming.dart';
// import 'interview_screen.dart';

class RequirementElicitationScreen extends StatefulWidget {
  const RequirementElicitationScreen({super.key});

  @override
  State<RequirementElicitationScreen> createState() => _RequirementElicitationScreenState();
}

class _RequirementElicitationScreenState extends State<RequirementElicitationScreen> {
  int stakeholderCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: "Select Elicitation Technique"),
      body: Padding(
        padding: kDefaultPaddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizeHeight20,
            Text("Choose the Best Elicitation Technique", style: txtStyle18AndBold),
            sizeHeight10,
            Text("The system selects a technique based on stakeholder count.", style: txtStyle14AndBlack),
            sizeHeight20,
            Text("Number of Stakeholders:", style: txtStyle16AndBold),
            sizeHeight10,
            CustomDropdown(
              hintText: "Select Stakeholders",
              options: ["1", "2", "3", "4", "5"],
              value: stakeholderCount.toString(),
              onChanged: (newValue) {
                setState(() {
                  stakeholderCount = int.parse(newValue!);
                });
              },
            ),
            sizeHeight30,
            MyButton(
              text: "Proceed",
              onPressed: () {
                if (stakeholderCount == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InterviewScreen()));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BrainstormingScreen()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
