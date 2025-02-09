import 'package:flutter/material.dart';

class RequirementProvider with ChangeNotifier {
  final List<String> _requirements = [];
  final Map<int, String> _categories = {};
  String? _projectName;
  String _numStakeholders = "1";
  bool _needsAnalyst = false;
  bool _needsReviewer = false;

  List<String> get requirements => _requirements;
  Map<int, String> get categories => _categories;
  String? get projectName => _projectName;
  String get numStakeholders => _numStakeholders;
  bool get needsAnalyst => _needsAnalyst;
  bool get needsReviewer => _needsReviewer;

  void addRequirement(String requirement) {
    _requirements.add(requirement);
    notifyListeners();
  }

  void removeRequirement(int index) {
    _requirements.removeAt(index);
    _categories.remove(index);
    notifyListeners();
  }

  void setProjectName(String name) {
    _projectName = name;
    notifyListeners();
  }

  void setNumStakeholders(String count) {
    _numStakeholders = count;
    notifyListeners();
  }

  void setNeedsAnalyst(bool value) {
    _needsAnalyst = value;
    notifyListeners();
  }

  void setNeedsReviewer(bool value) {
    _needsReviewer = value;
    notifyListeners();
  }

  void clear() {
    _requirements.clear();
    _categories.clear();
    _projectName = null;
    _numStakeholders = "1";
    _needsAnalyst = false;
    _needsReviewer = false;
    notifyListeners();
  }
}
