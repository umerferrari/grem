import 'package:flutter/material.dart';

// progress_provider.dart
class ProgressProvider with ChangeNotifier {
  int _currentLevel = 1;
  int _currentXP = 0;
  final List<String> _earnedBadges = [];

  int get currentLevel => _currentLevel;
  int get currentXP => _currentXP;
  List<String> get earnedBadges => _earnedBadges;
  int get xpToNextLevel => _currentLevel * 1000;

  void completeQuest() {
    _currentXP += 200;
    if (_currentXP >= xpToNextLevel) {
      _currentLevel++;
      _currentXP = 0;
    }
    _earnedBadges.add('Level $_currentLevel Badge');
    notifyListeners();
  }
}