
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/color.dart';
import 'Provider/add_project_provider.dart';
import 'Provider/authen_provider.dart';
import 'Provider/bottom_bar_provider.dart';
import 'Provider/image_picker_provider.dart';
import 'Provider/profile_provider.dart';
import 'Provider/progress_provider.dart';
import 'Provider/requirement_provider.dart';
import 'Screens/SplashScreen/splash_screen.dart';

import 'Widgets/error_show_screen.dart';


SharedPreferences pref = SharedPreferences.getInstance() as SharedPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  
  pref = await SharedPreferences.getInstance();

  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomBarProvider>(
          create: (_) => BottomBarProvider(),
        ),
        ChangeNotifierProvider<AddProjectProvider>(
          create: (_) => AddProjectProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider<AuthenProvider>(
          create: (_) => AuthenProvider(),
        ),
        ChangeNotifierProvider<ImagePickerProvider>(
          create: (_) => ImagePickerProvider(),
        ),
        ChangeNotifierProvider<RequirementProvider>(
          create: (_) => RequirementProvider(),
        ),
        ChangeNotifierProvider<ProgressProvider>(
          create: (_) => ProgressProvider(),
        ),
      ],
      child: const MyApp()));
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grem',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.mulish().fontFamily,
        // primarySwatch: mainColor,
        primaryColor: mainColor,
        primaryColorLight: mainColor,
        primaryColorDark: mainColor,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: textColor),
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w600, color: textColor),
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: textColor),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: textColor),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: textColor),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: textColor),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: mainColor),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: mainColor),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: mainColor),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: otherColor),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: otherColor),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: otherColor),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: mainColor),
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: mainColor),
          labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: mainColor),
        ),
      ),
      home: SplashScreen(),
      // ChatScreen(senderId: "675b24d999f7d757d11d667d",receiverId: "675b308299f7d757d11d6684",),
    );
  }
}


class ErrorWidgetClass extends StatefulWidget {
  final FlutterErrorDetails errorDetails;
  const ErrorWidgetClass({super.key, required this.errorDetails});

  @override
  State<ErrorWidgetClass> createState() => _ErrorWidgetClassState();
}

class _ErrorWidgetClassState extends State<ErrorWidgetClass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Custom Error",
      home: ErrorDisplayWidget(
        errorMessage: widget.errorDetails.exceptionAsString(),
      ),
    );
  }
}

fun(){

  // var token = UUid.toStirng();
  // login(){
  //   // response -> success {
  //   //----------------
  //   // ------=--
  //   // }
  // }
}



class CustomErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomErrorWidget({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    // Log the error details to the console
    // debugPrint('Error occurred: ${errorDetails.exceptionAsString()}');

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('An Error Occurred'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.redAccent.shade100,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 60,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Oops! Something went wrong.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  errorDetails.exceptionAsString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to the previous screen or perform any other desired action
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.redAccent,
                  ),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}