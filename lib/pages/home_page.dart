import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login_bloc/blocs/auth/auth_bloc.dart';
import 'package:flutter_firebase_login_bloc/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("home"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfilePage();
                }));
              },
              icon: Icon(Icons.person),
            ),
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequestEvent());
              },
              icon: Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: Text("home"),
      ),
    );
  }
}
