import 'package:flutter/material.dart';
import 'package:flychat/features/values/dimens.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.only(
            left: Dimens.getDimen(20),
            right: Dimens.getDimen(20),
            top: Dimens.getDimen(20),
            bottom: Dimens.getDimen(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _topview(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topview(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.translate(
          offset: const Offset(-10, 0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              size: Dimens.getDimen(30),
              Icons.arrow_back,
            ),
          ),
        ),
        Icon(
          Icons.account_circle,
          size: Dimens.getDimen(50),
        ),
        SizedBox(
          width: Dimens.getDimen(10),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rayhan Mahmud',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimens.getDimen(14),
              ),
            ),
            const Text('Active Now'),
          ],
        )
      ],
    );
  }
}
