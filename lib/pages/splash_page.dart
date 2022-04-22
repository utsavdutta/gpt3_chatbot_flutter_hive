import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login_bloc/blocs/auth/auth_bloc.dart';
import 'package:flutter_firebase_login_bloc/pages/home_page.dart';
import 'package:flutter_firebase_login_bloc/pages/signin_page.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/';
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unautheticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SignInPage.routeName,
            (route) {
              return route.settings.name ==
                      ModalRoute.of(context)!.settings.name
                  ? true
                  : false;
            },
          );
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.pushNamed(context, HomePage.routeName);
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
