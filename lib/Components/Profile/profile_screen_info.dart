
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/textStyle.dart';
import '../../Provider/authen_provider.dart';
import '../../utils/app_common.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenProvider>(
      builder: (context,authProvider,_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.45),
                    blurRadius: 24,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: cachedImage(authProvider.userInfoData != null && authProvider.userInfoData?.profileImage != null && authProvider.userInfoData!.profileImage!.imageUrl != null? authProvider.userInfoData!.profileImage!.imageUrl : "",
                  width: 140,radius: 300),
            ),
            const SizedBox(height: 21),
            // Text("datasd ${authProvider.userInfoData?.toJson()}"),
            Text(
              "${authProvider.userInfoData?.firstName ??""} ${authProvider.userInfoData?.lastName ?? ""}",
              style: txtStyle16AndBold,
            ),
            const SizedBox(height: 7),
            // Text(
            //   '${authProvider.userInfoData.}',
            //   style: txtStyle14AndBlack,
            // ),
            const SizedBox(height: 14),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                '${authProvider.userInfoData?.bio ?? ""}',
                // 'Experienced designer, shaping intuitive interfaces and seamless user journeys',
                textAlign: TextAlign.center,
                style: txtStyle14AndOther,
              ),
            ),
          ],
        );
      }
    );
  }
}