import 'package:flutter/material.dart';
import 'package:grem/Components/widget_extensions.dart';
import 'package:grem/Widgets/toast.dart';
import 'package:provider/provider.dart';
import '../../Constants/color.dart';
import '../../Constants/sizedbox.dart';
import '../../Constants/textStyle.dart';
import '../../Provider/requirement_provider.dart';
import '../../Widgets/appbar.dart';
import '../../Widgets/button.dart';
import '../../Widgets/textfield.dart';
import '../Interview/interview.dart';
import '../brain_storming.dart';
import '../quest_completion_screen.dart';

class StakeholderAddProject extends StatefulWidget {
  const StakeholderAddProject({super.key});

  @override
  State<StakeholderAddProject> createState() => _StakeholderAddProjectState();
}

class _StakeholderAddProjectState extends State<StakeholderAddProject> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _requirementController = TextEditingController();
  bool _needsAnalyst = false;
  bool _needsReviewer = false;

  @override
  Widget build(BuildContext context) {
    final reqProvider = Provider.of<RequirementProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kDefaultPaddingHorizontal,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizeHeight10,
                  Text('Requirement Definition', style: txtStyle22AndBold),
                  sizeHeight30,

                  // **Project Name**
                  Text('Project Name:', style: txtStyle14AndBold),
                  sizeHeight5,
                  CustomTextField(
                    hintText: 'Enter Project Name',
                    controller: _projectNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                    (value == null || value.trim().isEmpty) ? "Project Name is required" : null,
                    onChanged: (value) => reqProvider.setProjectName(value),
                  ),
                  sizeHeight20,

                  // **Add Requirements**
                  Text('Add Requirement:', style: txtStyle14AndBold),
                  sizeHeight5,
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Enter Requirement',
                          controller: _requirementController,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: mainColor),
                        onPressed: () {
                          if(reqProvider.requirements.length >= 5){
                            AppToast.show("Maximum 5 requirement are allowed.");
                          }else
                          if (_requirementController.text.trim().isNotEmpty) {
                            reqProvider.addRequirement(_requirementController.text.trim());
                            _requirementController.clear();
                          }
                        },
                      ),
                    ],
                  ),

                  if (reqProvider.requirements.isNotEmpty) ...[
                    sizeHeight10,
                    Text('Added Requirements:', style: txtStyle14AndBold),
                    sizeHeight5,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: reqProvider.requirements.asMap().entries.map((entry) {
                        int index = entry.key;
                        String req = entry.value;
                        return ListTile(
                          title: Text(req, style: txtStyle14AndBlack),
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity(vertical: -4),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => reqProvider.removeRequirement(index),
                          ),
                        );
                      }).toList(),
                    ),
                    sizeHeight20,
                  ],

                  // **Stakeholder Count**
                  Text('Number of Stakeholders:', style: txtStyle14AndBold),
                  sizeHeight5,
                  CustomDropdown(
                    hintText: "Select Stakeholders (1-5)",
                    options: ["1", "2", "3", "4", "5"],
                    value: reqProvider.numStakeholders,
                    onChanged: (newValue) {
                      reqProvider.setNumStakeholders(newValue!);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select the number of stakeholders";
                      }
                      return null;
                    },
                  ),
                  sizeHeight20,

                  // **Analyst/Reviewer Needed**
                  _buildRadioGroup(
                      'Requirement Analyst Needed?', _needsAnalyst, (v) => setState(() => _needsAnalyst = v)),
                  _buildRadioGroup(
                      'Reviewer Needed?', _needsReviewer, (v) => setState(() => _needsReviewer = v)),
                  sizeHeight20,

                  // **Submit Button**
                  MyButton(
                    text: "Submit",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (reqProvider.requirements.isEmpty) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text
                             AppToast.show(
                                "Please add at least one requirement");
                          // );
                          return;
                        } else if(reqProvider.numStakeholders == "1"){
                          InterviewScreen().launch(context);
                        }else{
                          BrainstormingScreen().launch(context);
                        }
                        // QuestCompletionScreen().launch(context);
                        print("Project Created Successfully");
                      }
                    },
                  ),
                  sizeHeight40,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioGroup(String title, bool value, Function(bool) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: txtStyle14AndBold),
        Row(
          children: [
            Radio<bool>(activeColor: mainColor, value: true, groupValue: value, onChanged: (v) => onChanged(v!)),
            Text('Yes', style: txtStyle14AndBlack),
            sizeWidth20,
            Radio<bool>(activeColor: mainColor, value: false, groupValue: value, onChanged: (v) => onChanged(v!)),
            Text('No', style: txtStyle14AndBlack),
          ],
        ),
      ],
    );
  }
}

