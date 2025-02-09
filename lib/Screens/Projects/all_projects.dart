import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grem/Components/widget_extensions.dart';
import 'package:grem/Constants/textStyle.dart';
import 'package:grem/Screens/Projects/view_project_details.dart';
import 'package:grem/Screens/StakeholderAddProject/stakeholder_add_project.dart';

import '../../Constants/color.dart';


class AllProjectView extends StatefulWidget {
  const AllProjectView({super.key});

  @override
  State<AllProjectView> createState() => _AllProjectViewState();
}

class _AllProjectViewState extends State<AllProjectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  bgColor,
      appBar:

      AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Projects",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                StakeholderAddProject().launch(context);
              },
              icon: Icon(CupertinoIcons.add_circled,color: Colors.white,))
        ],
      ),
      body: Column(
        children: [
          
          const SizedBox(height: 20),
          Expanded(child: AllProjectsViewList()),
        ],
      ),
    );
  }
}
Widget AllProjectsViewList() {
  // List<Map<String, dynamic>> users = [
  //   {"name": "John Wick", "avatar": avatarFour, "score": 234, "rank": 4},
  //   {"name": "Rocco Lampone", "avatar": avatarFive, "score": 200, "rank": 5},
  //   {"name": "Dalte126", "avatar": avatarSix, "score": 168, "rank": 6},
  //   {"name": "John Wick", "avatar": avatarFour, "score": 234, "rank": 4},
  //   {"name": "Rocco Lampone", "avatar": avatarFive, "score": 200, "rank": 5},
  //   {"name": "Dalte126", "avatar": avatarSix, "score": 168, "rank": 6},
  // ];

  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: 6,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        // final user = users[index];
        return ListTile(
          onTap: (){
            ViewProjectDetails().launch(context);
          },
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity(vertical: -4),
          title: Text("Project Name $index",style: txtStyle16AndBold,),
          subtitle: Text("Total Stakeholders: $index",style: txtStyle14AndOther,),
          trailing: Icon(Icons.arrow_forward_ios,size: 20,),
        );
      },
    ),
  );
}
