import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/util/bloc_observer.dart';
import 'data/repository/auth_implementation.dart';
import 'firebase_options.dart';
import 'true_heart_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthRepositoryImplementation();
  await authenticationRepository.user.first;
  runApp(TrueHeartApp(
    authRepository: authenticationRepository,
  ));
}
