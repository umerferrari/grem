import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grem/Components/Profile/profile_screen_settings.dart';
import 'package:grem/Components/widget_extensions.dart';

import '../../Constants/paths.dart';
import '../../Constants/sizedbox.dart';
import '../../Widgets/toast.dart';
import '../AuthScreen/EmailPassword/email_password.dart';
import '../AuthScreen/Login/login_with_email.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // final provider = Provider.of(context,listen: false);
      // dismissKeyboard(context: context);
      Future.delayed(Duration(seconds: 2), () {
        LoginWithEmailPassword().launch(context,isNewTask: true,);
       });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(splashScreenImage,fit: BoxFit.cover,width: double.maxFinite,height: double.maxFinite,),
    );
  }
}
