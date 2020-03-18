import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/backend/backend.dart';
import 'package:junto_beta_mobile/backend/repositories/app_repo.dart';
import 'package:junto_beta_mobile/models/models.dart';
import 'package:junto_beta_mobile/screens/collective/perspectives/expression_feed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider extends ChangeNotifier {
  UserDataProvider(
    this.userRepository,
    this.appRepository,
  ) {
    initialize();
  }
  final UserRepo userRepository;
  final AppRepo appRepository;

  String userAddress;
  UserData userProfile;
  bool twoColumnView = false;

  SharedPreferences sharedPreferences;

  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await getUserInformation();
  }

  Future<void> getUserInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> decodedUserData = jsonDecode(
      prefs.getString('user_data'),
    );

    userAddress = prefs.getString('user_id');
    userProfile = UserData.fromMap(decodedUserData);
    if (prefs.getBool('twoColumnView') != null) {
      twoColumnView = prefs.getBool('twoColumnView');
    }

    notifyListeners();
  }

  Future<void> switchColumnLayout(ExpressionFeedLayout layout) async {
    await appRepository.setLayout(layout == ExpressionFeedLayout.two);
    await getUserInformation();
    notifyListeners();
  }
}
