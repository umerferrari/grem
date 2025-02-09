
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grem/Components/common.dart';
import 'package:grem/Components/widget_extensions.dart';
import 'package:grem/Constants/paths.dart';
import 'package:grem/Constants/sizedbox.dart';
import 'package:grem/Widgets/button.dart';
import 'package:grem/Widgets/dialogBox.dart';

import '../../Components/Profile/profile_screen_info.dart';
import '../../Components/Profile/profile_screen_settings.dart';
import '../../Constants/color.dart';
import '../../Constants/textStyle.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            sizeHeight15,
            _buildProfileSection(),
            // _buildTabBar(),
            Expanded(child: _buildAchievementsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage(avatarOne),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(onPressed: (){
                EditProfile().launch(context);
              }, icon: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 16,
                child: Icon(Icons.edit,color: mainColor,size: 18,),)),
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Trang Tran",
          style: txtStyle20AndWhiteBold,
        ),
        Text(
          "Level 4",
          style: txtStyle16AndWhite,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTabBar() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: false,
          primaryColor:  Colors.green.withOpacity(0.1)
      ),
      home: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

        child: TabBar(
          controller: _tabController,
          labelStyle: txtStyle14AndMainBold,
          unselectedLabelStyle: txtStyle14AndOther,
          indicatorSize: TabBarIndicatorSize.tab,
          // unselectedLabelColor: otherColor,
          indicator: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),

          ),
          tabs: const [
            Tab(text: "Record"),
            Tab(text: "Statistics"),
            Tab(text: "Friends"),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsList() {
    List<Map<String, dynamic>> achievements = [
      {
        "title": "Elicitation Explorer",
        "description": "Complete your first requirement quest",
        "level": 1,
        "progress": 0.4,
        "icon": badgeOne,
        "claimable": true,
        "status_start": true
      },
      {
        "title": "Collaboration Champion",
        "description": "Successfully complete a brainstorming session",
        "level": 2,
        "progress": 0.6,
        "icon": badgeTwo,
        "claimable": false,
        "status_start": true
      },
      {
        "title": "Master Analyst",
        "description": "Validate and verify 5 stakeholder requirements",
        "level": 3,
        "progress": 1.0,
        "icon": badgeThree,
        "claimable": false,
        "status_start": false
      },
      {
        "title": "Gamification Guru",
        "description": "Maintain a 12-day streak in requirement tasks",
        "level": 4,
        "progress": 0.8,
        "icon": badgeFour,
        "claimable": false,
        "status_start": false
      },
    ];


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
        itemCount: achievements.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return _buildAchievementCard(achievement,claimButton: achievement["claimable"] == true? true: false);
        },
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement, {bool? claimButton}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(achievement["icon"]),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: greyColor200,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text("LV. ${achievement["level"]}",style: txtStyle10AndBold,),
                ),
              ),
            ],
          ),
          sizeWidth15,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement["title"],
                  style: txtStyle16AndBold,
                ),
                Text(
                  achievement["description"],
                  style: txtStyle14AndOther,
                ),
                const SizedBox(height: 5),
                claimButton == true?

                MyButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    dialogBox(
                      context: context,
                      listViewScrollPhysics: NeverScrollableScrollPhysics(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      content: Column(
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: IconButton(onPressed: (){pop();}, icon: Icon(Icons.close))),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(achievement["icon"]),
                          ),
                          sizeHeight15,
                          Text("Congratulations",style: txtStyle16AndMainBold,),
                          sizeHeight15,
                          // Text("Level. ${achievement["level"]}",style: txtStyle14AndGreen,),
                          // sizeHeight15,
                          Text("Great job! Keep going and take on the next challenge! 💪✨",textAlign: TextAlign.center,style: txtStyle16AndBold,),
                          sizeHeight30,
                          // MyButton(
                          //     onPressed: (){},
                          // ),
                        ],
                      )
                    );
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text("Reward Claimed for ${achievement["title"]}!")),
                    // );
                  },text: "Claim reward",)  :
                LinearProgressIndicator(
                  value: achievement["progress"],
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation(
                    // achievement["progress"] == 1.0 ? Colors.green : Colors.purple,
                    achievement["status_start"] == false? transparentColor : achievement["progress"] == 1.0 ? Colors.green : mainColor,
                  ),
                  minHeight: 5,
                ),
              ],
            ),
          ),
          if (achievement["status_start"] == false)
            CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 16,
              child: Icon(CupertinoIcons.lock_fill,color: whiteColor,size: 18,),),
        ],
      ),
    );
  }
}