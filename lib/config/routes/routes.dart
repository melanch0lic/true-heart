import 'package:flutter/material.dart';

import 'package:true_heart_app/pages/login_page/login_page.dart';

import '../../app_state.dart';
import '../../pages/home_page/home_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [const MaterialPage(child: HomePage())];
    case AppStatus.unauthenticated:
      return [const MaterialPage(child: LoginPage())];
  }
}
