import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login_bloc/blocs/auth/auth_bloc.dart';
import 'package:flutter_firebase_login_bloc/blocs/profile/profile_cubit.dart';
import 'package:flutter_firebase_login_bloc/blocs/signin/signin_cubit.dart';
import 'package:flutter_firebase_login_bloc/blocs/signup/signup_cubit.dart';
import 'package:flutter_firebase_login_bloc/pages/home_page.dart';
import 'package:flutter_firebase_login_bloc/pages/profile_page.dart';
import 'package:flutter_firebase_login_bloc/pages/signin_page.dart';
import 'package:flutter_firebase_login_bloc/pages/signup_page.dart';
import 'package:flutter_firebase_login_bloc/pages/splash_page.dart';
import 'package:flutter_firebase_login_bloc/pages/bottom_bar_navigator/tab_home_page.dart';
import 'package:flutter_firebase_login_bloc/repositories/auth_repository.dart';
import 'package:flutter_firebase_login_bloc/repositories/proflie_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository(
                firebaseFirestore: FirebaseFirestore.instance,
                firebaseAuth: FirebaseAuth.instance)),
        RepositoryProvider<ProfileRepository>(
            create: (context) => ProfileRepository(
                firebaseFirestore: FirebaseFirestore.instance))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: ((context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>()))),
          BlocProvider<SigninCubit>(
              create: ((context) =>
                  SigninCubit(authRepository: context.read<AuthRepository>()))),
          BlocProvider<SignupCubit>(
              create: ((context) =>
                  SignupCubit(authRepository: context.read<AuthRepository>()))),
          BlocProvider<ProfileCubit>(
              create: ((context) => ProfileCubit(
                  profileRepository: context.read<ProfileRepository>())))
        ],
        child: MaterialApp(
          title: 'Login',
          theme: ThemeData.dark(),
          home: const SplashPage(),
          routes: {
            SignUpPage.routeName: (context) => const SignUpPage(),
            SignInPage.routeName: (context) => const SignInPage(),
            TabHomePage.routeName: (context) => const TabHomePage(),
            HomePage.routeName: (context) => const HomePage(),
            ProfilePage.routeName: (context) => const ProfilePage(),
          },
        ),
      ),
    );
  }
}
