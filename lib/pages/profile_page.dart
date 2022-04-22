import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login_bloc/blocs/auth/auth_bloc.dart';
import 'package:flutter_firebase_login_bloc/blocs/profile/profile_cubit.dart';
import 'package:flutter_firebase_login_bloc/utils/error_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() {
    final uid = context.read<AuthBloc>().state.user!.uid;
    context.read<ProfileCubit>().getProfile(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequestEvent());
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body:
          BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
        if (state.profileStatus == ProfileStatus.error) {
          errorDialog(context, state.error);
        }
      }, builder: (context, state) {
        if (state.profileStatus == ProfileStatus.initial) {
          return Container();
        } else if (state.profileStatus == ProfileStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.profileStatus == ProfileStatus.error) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.error,
                  size: 70,
                ),
                SizedBox(width: 20.0),
                Text(
                  'Ooops!\nTry again',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        }
        return Card(
            child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'uid: ${state.user.id}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'name: ${state.user.name}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'email: ${state.user.email}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'point: ${state.user.point}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'rank: ${state.user.rank}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ));
      }),
    );
  }
}
