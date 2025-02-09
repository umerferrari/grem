import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grem/Components/widget_extensions.dart';
import 'package:grem/Provider/image_picker_provider.dart';
import 'package:grem/Screens/AuthScreen/welcome_screen.dart';
import 'package:grem/Screens/BottomBar/bottom_bar.dart';
import 'package:grem/Screens/SplashScreen/splash_screen.dart';
import 'package:grem/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/toast.dart';
import '../modals/login_model.dart';


class AuthenProvider extends ChangeNotifier {

  final formKey = GlobalKey<FormState>();
  final formKeyProfile = GlobalKey<FormState>();
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyForgot = GlobalKey<FormState>();
  UserInfoModel? userInfoData;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  String? selectedRole;
  editProfileData(){
    final provider = Provider.of<ImagePickerProvider>(navigatorKey.currentState!.context,listen: false);
    provider.selectedImage = null;
    // firstNameController = TextEditingController(text: userInfoData?.firstName ?? "");
    // lastNameController = TextEditingController(text: userInfoData?.lastName ?? "");
    // phoneFullNumberController = TextEditingController(text: userInfoData?. ?? "");
    notifyListeners();
  }

  allAuthControllerNullFun(){
    emailController.clear();
    passwordController.clear();
    selectedRole = null;
    organizationController.clear();
    nameController.clear();
    notifyListeners();
  }

  bool isPasswordShowBool = false;

  isPassShowFun(){
    isPasswordShowBool = !isPasswordShowBool;
    notifyListeners();
  }


  logoutFun() async {
    await pref.clear();

    if(navigatorKey.currentState!.mounted){
    SplashScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
    }
  }

  Future<void> saveUserDataLocally({
    required String userId,
    required String name,
    required String role,
    required String organization,
    required String email,
    required int imageIndex, // Storing as index
  }) async {
    try {
      // SharedPreferences pref = await SharedPreferences.getInstance();

      await pref.setString('userId', userId);
      await pref.setString('name', name);
      await pref.setString('role', role);
      await pref.setString('organization', organization);
      await pref.setString('email', email);
      await pref.setInt('user_image', imageIndex); // Storing index as int

      AppToast.show("User data saved locally!");
    } catch (e) {
      AppToast.show("Failed to save data: ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>?> getUserDataFromLocal() async {
    try {
      // SharedPreferences pref = await SharedPreferences.getInstance();

      String? userId = pref.getString('userId');
      String? name = pref.getString('name');
      String? role = pref.getString('role');
      String? organization = pref.getString('organization');
      String? email = pref.getString('email');
      int? imageIndex = pref.getInt('user_image');

      if (userId == null || email == null) {
        return null; // No data found
      }

      return {
        'userId': userId,
        'name': name,
        'role': role,
        'organization': organization,
        'email': email,
        'user_image': 'user_image_$imageIndex',
      };
    } catch (e) {
      AppToast.show("Failed to retrieve data: ${e.toString()}");
      return null;
    }
  }

  void loadUserData() async {
    Map<String, dynamic>? userData = await getUserDataFromLocal();
    if (userData != null) {
      print("User Data: $userData");
    } else {
      print("No user data found.");
    }
  }



  Future<void> clearUserInfo() async {
    await pref.clear(); // Clears all keys
  }

  Future<bool> isLoggedIn() async {
    return pref.getBool('isLoggedIn') ?? false;
  }

  Future<Map<String, dynamic>?> getUserInfoFromLocalStorage() async {
    String? userInfoString = pref.getString('userInfo');
    if (userInfoString != null) {
      return jsonDecode(userInfoString); // Convert JSON string back to Map
    }
    return null;
  }


  void checkLoginStatus() async {
    bool loggedIn = await isLoggedIn();
    if (loggedIn) {
      Map<String, dynamic>? userInfo = await getUserInfoFromLocalStorage();
      if (userInfo != null) {
        print("User Info: ${userInfo.toString()}"); // Access user details here
        userInfoData = UserInfoModel.fromJson(userInfo);
        notifyListeners();
        if(navigatorKey.currentState!.mounted){
          BottomBar().launch(navigatorKey.currentState!.context, isNewTask: true);
          // HomeScreen().launch(navigatorKey.currentState!.context, isNewTask: true);
        }
      } else {
        pref.clear(); // Clear corrupted data
        if(navigatorKey.currentState!.mounted){
        // WelcomeScreen().launch(navigatorKey.currentState!.context, isNewTask: true);
          // HomeScreen().launch(navigatorKey.currentState!.context, isNewTask: true);
        }
      }
    } else {
      if(navigatorKey.currentState!.mounted){
      // WelcomeScreen().launch(navigatorKey.currentState!.context, isNewTask: true);
      }
    }
  }

/// USer account create
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required int imageIndex, // Storing as index
  }) async {
    try {
      // Show loading indicator
      showMyWaitingModal(context: context);
      // Create user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // Get user ID
      String uid = userCredential.user!.uid;
      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'userId': uid,
        'name': nameController.text,
        'role': selectedRole,
        'organization': organizationController.text,
        'email': email,
        'user_image': imageIndex, // Store as index reference
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      });
        await saveUserDataLocally(
        userId: uid,
        name: nameController.text,
        role: selectedRole ??"",
        organization: organizationController.text,
        email: email,
        imageIndex: imageIndex,
        ).then((e){

          // Save data locally
          BottomBar().launch(context,isNewTask: true);
        });
      // Success message
      AppToast.show("Account created successfully!");
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred. Please try again.";
      if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already in use.";
      } else if (e.code == 'weak-password') {
        errorMessage = "Your password is too weak.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      }
      AppToast.show(errorMessage);
    } catch (e) {
      AppToast.show("Something went wrong: ${e.toString()}");
    }
  }
}