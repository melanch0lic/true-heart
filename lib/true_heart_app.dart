import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_bloc.dart';
import 'app_state.dart';
import 'domain/repository/auth_repository.dart';
import 'presentation/pages/home_page/home_page.dart';
import 'presentation/pages/login_page/login_page.dart';

class TrueHeartApp extends StatelessWidget {
  final AuthRepository authRepository;
  const TrueHeartApp({super.key, required this.authRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authenticationRepository: authRepository),
        child: MaterialApp(
            title: 'True Heart',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            home: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
              if (state.status == AppStatus.authenticated) {
                return const HomePage();
              }
              return const LoginPage();
            })),
      ),
    );
  }
}
