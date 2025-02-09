import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/color.dart';
import '../../Constants/textStyle.dart';
import '../../Provider/authen_provider.dart';
import '../../Provider/bottom_bar_provider.dart';
import '../LeaderBoard/leader_board.dart';
import '../ProfileScreen/profile_screen.dart';
import '../Projects/all_projects.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<BottomBarProvider>(context, listen: false);
      provider.onItemTap(0);
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    LeaderboardScreen(),
    AllProjectView(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<BottomBarProvider, AuthenProvider>(
      builder: (context, provider, authProvider, child) {
        return Scaffold(
          body: _widgetOptions[provider.selectedIndex],
          bottomNavigationBar: WillPopScope(
            onWillPop: () async {
              if (provider.selectedIndex == 0) {
                return true;
              } else {
                provider.onItemTap(0);
                return false;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
              ),
              child: BottomNavigationBar(
                // useLegacyColorScheme: false,
                // type: BottomNavigationBarType.shifting,  // Ensure even spacing
                backgroundColor: whiteColor,
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Icon(CupertinoIcons.home),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Icon(Icons.pages),
                    ),
                    label: 'Projects',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Icon(CupertinoIcons.profile_circled),
                    ),
                    label: 'Profile',
                  ),
                ],
                currentIndex: provider.selectedIndex,
                selectedItemColor: mainColor,
                unselectedItemColor: otherColor,
                selectedLabelStyle: txtStyle14AndMainBold,
                unselectedLabelStyle: txtStyle14AndBlack,
                iconSize: 24.0,
                onTap: (int index) {
                  provider.onItemTap(index);
                },
                // onTap: null,
                elevation: 0,
              ),
            ),
          ),

        );
      },
    );
  }
}
