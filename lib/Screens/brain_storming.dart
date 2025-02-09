import 'package:flutter/material.dart';
import 'package:grem/Components/widget_extensions.dart';
import 'package:grem/Screens/quest_completion_screen.dart';
import 'package:grem/Widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:grem/Constants/color.dart';
import 'package:grem/Constants/sizedbox.dart';
import 'package:grem/Constants/textStyle.dart';
import 'package:grem/Widgets/appbar.dart';
import 'package:grem/Widgets/textfield.dart';

class BrainstormingScreen extends StatefulWidget {
  const BrainstormingScreen({super.key});

  @override
  _BrainstormingScreenState createState() => _BrainstormingScreenState();
}

class _BrainstormingScreenState extends State<BrainstormingScreen> {
  final TextEditingController _ideaController = TextEditingController();
  final List<String> _ideas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: appBar(title: 'Brainstorming Session'),
      body: Padding(
        padding: kDefaultPaddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Collaborative Header
            Text(
              'Add your ideas (${_ideas.length} collected)',
              style: txtStyle18AndBold,
            ),
            sizeHeight20,

            // Idea Input
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Enter idea...',
                    controller: _ideaController,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: mainColor),
                  onPressed: () {
                    if (_ideaController.text.trim().isNotEmpty) {
                      setState(() => _ideas.add(_ideaController.text.trim()));
                      _ideaController.clear();
                    }
                  },
                ),
              ],
            ),
            sizeHeight20,

            // Idea List
            Expanded(
              child: ListView.builder(
                itemCount: _ideas.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(vertical: -4),
                  leading: const Icon(Icons.lightbulb, color: yellowColor),
                  title: Text(_ideas[index], style: txtStyle14AndBlack),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => setState(() => _ideas.removeAt(index)),
                  ),
                ),
              ),
            ),
            sizeHeight10,
            // Video Call & Finish
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _launchVideoCall('zoom'),
                      icon: const Icon(Icons.video_call,color: whiteColor,),
                      label: Text('Join Google Meet', style: txtStyle14AndWhiteBold),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: redColor,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),

                      ),
                    ),
                  ),
                  sizeWidth15,
                  Expanded(
                    child: MyButton(
                      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 15),
                      onPressed: () => QuestCompletionScreen().launch(context),
                      text: 'Finish Session'
                    ),
                  ),
                ],
              ),
            ),
            sizeHeight20,
          ],
        ),
      ),
    );
  }

  void _launchVideoCall(String platform) async {
    const meetUrl = 'https://meet.google.com/abc-xyz';
    const zoomUrl = 'https://zoom.us/j/123456';
    final url = platform == 'googlemeet' ? meetUrl : zoomUrl;

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}