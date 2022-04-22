import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login_bloc/repositories/openai_repository.dart';

class SendMessageChatBoxWidget extends StatefulWidget {
  const SendMessageChatBoxWidget({Key? key}) : super(key: key);

  @override
  State<SendMessageChatBoxWidget> createState() =>
      _SendMessageChatBoxWidgetState();
}

class _SendMessageChatBoxWidgetState extends State<SendMessageChatBoxWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _message;

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Future<void> _submit() async {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      context.read<OpenAiRepository>().chatPrompt(_message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: autovalidateMode,
                    child: TextFormField(
                      autofocus: true,
                      style: const TextStyle(fontSize: 18.0),
                      decoration: const InputDecoration(
                        hintText: 'send message',
                      ),
                      validator: (String? input) {
                        if (input == null ||  input.trim().length > 250) {
                          return 'message limit is 250 characters';
                        }
                        return null;
                      },
                      onSaved: (String? input) {
                        _message = input;
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  IconButton(onPressed: _submit, icon: const Icon(Icons.send)),
            )
          ],
        ),
      ),
    );
  }
}
