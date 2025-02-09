import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grem/Constants/color.dart';
import 'package:grem/Widgets/appbar.dart';
import 'package:grem/Widgets/url_laucher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/paths.dart';
import '../../Constants/sizedbox.dart';
import '../../Constants/textStyle.dart';
import '../../Provider/requirement_provider.dart';

class ViewProjectDetails extends StatefulWidget {
  const ViewProjectDetails({super.key});

  @override
  State<ViewProjectDetails> createState() => _ViewProjectDetailsState();
}

class _ViewProjectDetailsState extends State<ViewProjectDetails> {
  List<String> dummyRequirements = [
    "The system shall allow users to log in using email and password.",
    "The application shall support real-time notifications for updates.",
    "The user interface shall be responsive across different screen sizes.",
    "The system shall store and retrieve user preferences securely.",
    "The application shall provide an analytics dashboard for stakeholders."
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<RequirementProvider>(
      builder: (context,reqProvider,_) {
        return Scaffold(
          backgroundColor: scaffoldColor,
          appBar: appBar(
            title: "Overview",
          ),
          body: SingleChildScrollView(
            padding: kDefaultPaddingHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Project Name:', style: txtStyle14AndBold),
                sizeHeight5,
                Text("Lorem Ipsum",style: txtStyle14AndOther,),
                sizeHeight15,
                Text('Requirement:', style: txtStyle14AndBold),
                sizeHeight5,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // children: reqProvider.requirements.asMap().entries.map((entry) {
                  children: dummyRequirements.asMap().entries.map((entry) {
                    int index = entry.key;
                    String req = entry.value;
                    return ListTile(
                      dense: true,
                      leading:  CircleAvatar(
                        radius: 3,
                        backgroundColor: mainColor,
                      ),
                      minLeadingWidth: 5,
                      title: Text(req, style: txtStyle14AndBlack),
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(vertical: -4),
                    );
                  }).toList(),
                ),
                sizeHeight15,
                Text('Number of Stakeholders:', style: txtStyle14AndBold),
                sizeHeight5,
                Text('3', style: txtStyle14AndOther),
                sizeHeight15,
                Text('Requirement Analyst Need:', style: txtStyle14AndBold),
                sizeHeight5,
                Chip(
                  label: Text("Yes",style: txtStyle14AndWhiteBold.copyWith(fontWeight: FontWeight.normal),),
                  backgroundColor: mainColor,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(31)
                  ),
                ),
                sizeHeight15,
                Text('Reviewer Need:', style: txtStyle14AndBold),
                sizeHeight5,
                Chip(
                  label: Text("No",style: txtStyle14AndWhiteBold.copyWith(fontWeight: FontWeight.normal),),
                  backgroundColor: mainColor,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(31)
                  ),
                ),
                sizeHeight15,
                Text('Interview:', style: txtStyle16AndMainBold),
                sizeHeight10,
                Text('What are the primary business objectives?', style: txtStyle14AndBold),
                sizeHeight5,
                Text('Improve efficiency, reduce operational costs, and enhance user experience. Increase revenue streams through automation and data-driven decision-making.', style: txtStyle14AndOther),
                sizeHeight10,
                Text('What are the pain points in the current system?', style: txtStyle14AndBold),
                sizeHeight5,
                Text(' Inefficiencies due to manual processes leading to delays and errors. Lack of scalability and high operational costs hinder growth and user satisfaction.', style: txtStyle14AndOther),
                sizeHeight10,
                Text('How should the solution prioritize scalability vs cost?', style: txtStyle14AndBold),
                sizeHeight5,
                Text('Focus on a balance by ensuring scalability while keeping initial costs low. Invest in modular architecture to scale efficiently as demand grows.', style: txtStyle14AndOther),
                sizeHeight15,
                Text('Meet Link:', style: txtStyle14AndBold),
                sizeHeight5,
                RichText(
                  text: TextSpan(
                    text: zoomMeet,
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        launchURL(url: zoomMeet,launchMode: LaunchMode.externalApplication);
                      },
                  ),
                ),
                sizeHeight15,
              ],
            ),
          ),
        );
      }
    );
  }
}
