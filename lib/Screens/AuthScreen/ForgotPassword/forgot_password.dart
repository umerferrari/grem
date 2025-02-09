import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constants/sizedbox.dart';
import '../../../Constants/textStyle.dart';
import '../../../Provider/authen_provider.dart';
import '../../../Widgets/appbar.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/textfield.dart';
import '../../../Widgets/validations.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
            appBar: appBar(),
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
                        'Forgot Password',
                        style: txtStyle22AndBold,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your email to recover your account.',
                        textAlign: TextAlign.start,
                        style: txtStyle14AndBlack,
                      ),
                      const SizedBox(height: 39),
                      Form(
                        key: authProvider.formKeyForgot,
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
                          ],
                        ),
                      ),
                      sizeHeight30,
                      MyButton(text: "Continue", onPressed: (){
                        if (authProvider.formKeyForgot.currentState!.validate()) {
                          // Validation passed
                          print("Form is valid");
                          // authProvider.loginAccountFun();
                        } else {
                          // Validation failed
                          print("Form is invalid");
                        }
                      }),
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
