import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AddProjectProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for TextFields
  TextEditingController projectNameController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();

  // Dropdown selections
  String? _selectedTechnique;
  String? _selectedStakeholderCount;

  // Quest Completion Checkbox
  bool _isQuestCompleted = false;

  // Requirement Analyst Selection
  bool _isRequirementAnalystNeeded = false;

  // Reviewer Selection
  bool _isReviewerNeeded = false;

  // Getters
  String? get selectedTechnique => _selectedTechnique;
  String? get selectedStakeholderCount => _selectedStakeholderCount;
  bool get isQuestCompleted => _isQuestCompleted;
  bool get isRequirementAnalystNeeded => _isRequirementAnalystNeeded;
  bool get isReviewerNeeded => _isReviewerNeeded;

  // Setters (with notifyListeners)
  set selectedTechnique(String? value) {
    _selectedTechnique = value;
    notifyListeners();
  }

  set selectedStakeholderCount(String? value) {
    _selectedStakeholderCount = value;
    notifyListeners();
  }

  set isQuestCompleted(bool value) {
    _isQuestCompleted = value;
    notifyListeners();
  }

  set isRequirementAnalystNeeded(bool value) {
    _isRequirementAnalystNeeded = value;
    notifyListeners();
  }

  set isReviewerNeeded(bool value) {
    _isReviewerNeeded = value;
    notifyListeners();
  }

  // Validate and submit form
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    projectNameController.dispose();
    requirementsController.dispose();
    super.dispose();
  }
}

