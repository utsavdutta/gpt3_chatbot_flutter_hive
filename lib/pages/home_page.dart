import 'package:flutter/material.dart';
import 'package:flutter_firebase_login_bloc/models/chat_hive_model.dart';
import 'package:flutter_firebase_login_bloc/pages/profile_page.dart';
import 'package:flutter_firebase_login_bloc/widgets/chat_bubble_widget.dart';
import 'package:flutter_firebase_login_bloc/widgets/send_message_chat_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = new ScrollController();
  final chatbox = Hive.box('chats');
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Liliya"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProfilePage();
                }));
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ValueListenableBuilder(
                        valueListenable: chatbox.listenable(),
                        builder: (context, box, widget) {
                          return ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final ChatHiveModel chatHiveModel =
                                  chatbox.getAt(index);
                              return ChatBubble(chat: chatHiveModel);
                            },
                            itemCount: chatbox.length,
                          );
                        },
                      ))),
            ),
            const SendMessageChatBoxWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
