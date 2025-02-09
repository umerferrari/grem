
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grem/Components/widget_extensions.dart';
import 'package:grem/Constants/paths.dart';
import 'package:provider/provider.dart';

import '../../../Constants/color.dart';
import '../../../Constants/sizedbox.dart';
import '../../../Constants/textStyle.dart';
import '../../../Provider/authen_provider.dart';
import '../../../Widgets/appbar.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/textfield.dart';
import '../../../Widgets/validations.dart';
import '../../StakeholderAddProject/stakeholder_add_project.dart';

class EmailPasswordScreen extends StatefulWidget {
  const EmailPasswordScreen({super.key});

  @override
  State<EmailPasswordScreen> createState() => _EmailPasswordScreenState();
}

class _EmailPasswordScreenState extends State<EmailPasswordScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e){
      Provider.of<AuthenProvider>(context,listen: false).allAuthControllerNullFun();
    });
  }

List<String> avatarList = [
  avatarOne,
  avatarTwo,
  avatarThree,
  avatarFour,
  avatarFive,
  avatarSix
];
  int selectedIndex = 0; // Stores selected index
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
                      'Sign up',
                      style: txtStyle22AndBold,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Welcome to GREM! Customize your avatar, select your role, and start collaborating.',
                      textAlign: TextAlign.start,
                      style: txtStyle14AndBlack,
                    ),
                    sizeHeight30,
                    Text("Choose an avatar",style: txtStyle16AndBold,),
                    sizeHeight15,
                    GridView.builder(
                      itemCount: avatarList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 items per row
                        crossAxisSpacing: 0,
                        // mainAxisExtent: 30.0,
                        // childAspectRatio: 1.0,
                        mainAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) {
                        bool isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index; // Update selected avatar
                            });
                          },
                          child: Stack(
                            children: [
                              Image.asset(avatarList[index],height: 100,),
                              selectedIndex == index?
                                  Icon(CupertinoIcons.checkmark_alt_circle_fill,color: mainColor,) : SizedBox(),
                            ],
                          ),
                        );
                      },
                    ),
                    sizeHeight15,
                    Form(
                      key: authProvider.formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: 'Name',
                            obscureText: false,
                            controller: authProvider.nameController,
                            keyboardType: TextInputType.name,
                            validator: AllValidation().nameValidator,
                          ),
                          sizeHeight10,
                      CustomDropdown(
                        hintText: "Choose role",
                        options: ["Stakeholder", "Requirement Analyst", "Reviewer"],
                        value: authProvider.selectedRole,
                        onChanged: (newValue) {
                          authProvider.selectedRole = newValue;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a role";
                          }
                          return null;
                        },
                      ),
                          sizeHeight10,
                          CustomTextField(
                            hintText: 'Organization',
                            obscureText: false,
                            controller: authProvider.organizationController,
                            keyboardType: TextInputType.text,
                            validator: AllValidation().organizationValidator,
                          ),
                          sizeHeight10,
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
                        ],
                      ),
                    ),
                    sizeHeight30,
                    MyButton(text: "Continue", onPressed: (){
                      if (authProvider.formKey.currentState!.validate()) {
                        // Validation passed
                        // print("Form is valid");
                        StakeholderAddProject().launch(context);
                        // authProvider.signUpUser(context: context, email: authProvider.emailController.text, password: authProvider.passwordController.text, imageIndex: selectedIndex);
                      } else {
                        // Validation failed
                        print("Form is invalid");
                      }
                      }),
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
