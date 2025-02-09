import 'package:grem/Components/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constants/color.dart';
import '../../../Constants/sizedbox.dart';
import '../../../Constants/textStyle.dart';
import '../../../Provider/authen_provider.dart';
import '../../../Widgets/appbar.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/textfield.dart';
import '../../../Widgets/validations.dart';
import '../../BottomBar/bottom_bar.dart';
import '../../StakeholderAddProject/stakeholder_add_project.dart';
import '../EmailPassword/email_password.dart';
import '../ForgotPassword/forgot_password.dart';

class LoginWithEmailPassword extends StatefulWidget {
  const LoginWithEmailPassword({super.key});

  @override
  State<LoginWithEmailPassword> createState() => _LoginWithEmailPasswordState();
}

class _LoginWithEmailPasswordState extends State<LoginWithEmailPassword> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e){
      Provider.of<AuthenProvider>(context,listen: false).allAuthControllerNullFun();
    });
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<AuthenProvider>(
        builder: (context,authProvider,_) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(
              leadOnTap: null,
              leadIcon: SizedBox()
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  width: double.infinity,
                  // constraints: const BoxConstraints(maxWidth: 480),
                  padding: kDefaultPaddingHorizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizeHeight10,
                      Text(
                        'Sign in',
                        style: txtStyle22AndBold,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Welcome back! Sign in to continue.',
                        textAlign: TextAlign.start,
                        style: txtStyle14AndBlack,
                      ),
                      const SizedBox(height: 39),
                      Form(
                        key: authProvider.formKeyLogin,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Email',
                              obscureText: false,
                              controller: authProvider.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: AllValidation().emailValidator,
                            ),
                            sizeHeight10,
                            CustomTextField(
                              hintText: 'Password',
                              obscureText: authProvider.isPasswordShowBool,
                              controller: authProvider.passwordController,
                              onChanged: (e){
                                authProvider.passwordController.text = e;
                              },
                              validator: AllValidation().passwordValidator,
                              suffixIcon: IconButton(
                                onPressed: (){
                                  authProvider.isPassShowFun();
                                },
                                icon: Icon(Icons.remove_red_eye_outlined ),
                              ),
                            ),
                            sizeHeight10,
                          ],
                        ),
                      ),
                      // sizeHeight30,
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            onPressed: (){
                              ForgotPassword().launch(context);
                            },
                            child: Text("Forgot Password",style: txtStyle14AndMainBold,)),
                      ),
                      sizeHeight30,
                      MyButton(text: "Continue", onPressed: (){
                        if (authProvider.formKeyLogin.currentState!.validate()) {
                          // Validation passed
                          print("Form is valid");
                          // authProvider.loginAccountFun();
                          BottomBar().launch(context);
                        } else {
                          // Validation failed
                          // BottomBar().launch(context);
                          print("Form is invalid");
                        }
                      }),
                      sizeHeight30,
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",style: txtStyleByDefualtAndTextBlack,),
                        TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: mainColor,
                            ),
                            onPressed: (){
                              EmailPasswordScreen().launch(context);
                              // StakeholderAddProject().launch(context);
                            }, child: Text("Sign Up",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor
                        ),)),
                      ],
                    ),
                      sizeHeight30,
                      ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
