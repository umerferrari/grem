import 'package:flutter/material.dart';
import 'package:grem/Constants/color.dart';
import 'package:grem/Constants/paths.dart';
import 'package:grem/Constants/textStyle.dart';
import 'package:grem/Widgets/appbar.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
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
      backgroundColor:  bgColor,
      appBar:

      AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Leaderboard",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: false,
              primaryColor:  Colors.green.withOpacity(0.1)
            ),
            home: Container(
              decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.2),
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TabBar(
                controller: _tabController,
                // labelColor: mainColor,
                labelStyle: txtStyle14AndMainBold,
                unselectedLabelStyle: txtStyle14AndOther,
                indicatorSize: TabBarIndicatorSize.tab,
                // unselectedLabelColor: otherColor,
                indicator: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),

                ),
                tabs: const [
                  Tab(text: "Today"),
                  Tab(text: "This week"),
                  Tab(text: "All time"),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildPodium(),
          const SizedBox(height: 20),
          Expanded(child: _buildLeaderboardList()),
        ],
      ),
    );
  }

  Widget _buildPodium() {
    return Container(
      color: bgColor,
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(colors: [mainColor, bgColor])
      // ),
      width: double.maxFinite,
      height: 280,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _podiumPlace("Johnny", avatarOne, 320, 2, Colors.purple[300]!),
            _podiumPlace("Jenifer", avatarTwo, 320, 1, Colors.yellow[700]!),
            _podiumPlace("Trang", avatarThree, 250, 3, Colors.orange[400]!),
          ],
        ),
      ),
    );
  }

  Widget _podiumPlace(String name, String avatar, int score, int position, Color color) {
    double height = position == 1 ? 155 : position == 2 ? 150 : 110;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(avatar),
        ),
        const SizedBox(height: 5),

        position == 1 ?
        Expanded(
          // flex: 1,
          child: Container(
            width: 80,
            // height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${position == 1 ? '1st' : position == 2 ? '2nd' : '3rd'}",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "${score}p",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ) :Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${position == 1 ? '1st' : position == 2 ? '2nd' : '3rd'}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "${score}p",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildLeaderboardList() {
    List<Map<String, dynamic>> users = [
      {"name": "John Wick", "avatar": avatarFour, "score": 234, "rank": 4},
      {"name": "Rocco Lampone", "avatar": avatarFive, "score": 200, "rank": 5},
      {"name": "Dalte126", "avatar": avatarSix, "score": 168, "rank": 6},
      {"name": "John Wick", "avatar": avatarFour, "score": 234, "rank": 4},
      {"name": "Rocco Lampone", "avatar": avatarFive, "score": 200, "rank": 5},
      {"name": "Dalte126", "avatar": avatarSix, "score": 168, "rank": 6},
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
        itemCount: users.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(user["avatar"]),
            ),
            title: Text(
              user["name"],
              style: txtStyle16AndBold,
            ),
            subtitle: Text("${user["score"]}p",),
            trailing: Text(
              "${user["rank"]}th",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}