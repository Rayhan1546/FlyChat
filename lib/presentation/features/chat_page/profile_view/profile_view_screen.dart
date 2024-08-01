import 'package:flutter/material.dart';
import 'package:flychat/data/response_models/user_model.dart';
import 'package:flychat/util/values/dimens.dart';
import 'package:intl/intl.dart';

class ProfileViewScreen extends StatelessWidget {
  final UserModel user;

  const ProfileViewScreen({super.key, required this.user});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(Dimens.getDimen(20)),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _backButton(context),
            SizedBox(
              height: Dimens.getDimen(20),
            ),
            _profilePicture(context),
            SizedBox(
              height: Dimens.getDimen(30),
            ),
            _profileDetails(context),
            SizedBox(
              height: Dimens.getDimen(30),
            ),
            _userDescription(context),
          ],
        ),
      )),
    );
  }

  Widget _backButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Transform.translate(
        offset: const Offset(-10, 0),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            size: Dimens.getDimen(30),
            Icons.arrow_back,
          ),
        ),
      ),
    );
  }

  Widget _profilePicture(BuildContext context) {
    return Container(
      height: Dimens.getDimen(150),
      width: Dimens.getDimen(150),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(70),
        image: DecorationImage(
          image: NetworkImage(user.profilePictureUrl),
        ),
      ),
    );
  }

  Widget _profileDetails(BuildContext context) {
    return Column(
      children: [
        Text(
          user.username,
          style: TextStyle(
            fontSize: Dimens.getDimen(20),
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(
          height: Dimens.getDimen(10),
        ),
        Text(
          DateFormat('yMMMd').format(user.createdAt!).toString(),
          style: TextStyle(
            fontSize: Dimens.getDimen(15),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _userDescription(BuildContext context) {
    return Text(
      'Hello everyone, my name is Rayhan Mahmud. I am eager to talk with you.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: Dimens.getDimen(15),
      ),
    );
  }
}
