import 'package:flutter/material.dart';
import 'package:flychat/data/response_models/user_model.dart';
import 'package:flychat/features/home/home_screen_viewmodel.dart';
import 'package:flychat/util/values/dimens.dart';
import 'package:intl/intl.dart';

HomeScreenViewmodel viewmodel = HomeScreenViewmodel();

bottomSheetUi(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.grey[800],
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          padding: EdgeInsets.all(
            Dimens.getDimen(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: Dimens.getDimen(22),
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _userdetails(context),
            ],
          ),
        ),
      );
    },
  );
}

Widget _userdetails(BuildContext context) {
  return ValueListenableBuilder(
    valueListenable: viewmodel.userData,
    builder: (context, user, _) => Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: user == null
              ? const CircularProgressIndicator()
              : ClipOval(
                  child: Image.network(
                    user.profilePictureUrl,
                    width: Dimens.getDimen(110),
                    height: Dimens.getDimen(110),
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        SizedBox(
          height: Dimens.getDimen(12),
        ),
        _activeStatus(context, user!),
        SizedBox(
          height: Dimens.getDimen(7),
        ),
        _name(context, user),
        SizedBox(
          height: Dimens.getDimen(7),
        ),
        _createdAt(context, user),
      ],
    ),
  );
}

Widget _activeStatus(BuildContext context, UserModel user) {
  return Row(
    children: [
      Text(
        'Active_Status:',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: Dimens.getDimen(15),
        ),
      ),
      const Spacer(),
      Text(
        'active',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: Dimens.getDimen(15),
        ),
      ),
    ],
  );
}

Widget _name(BuildContext context, UserModel user) {
  return Row(
    children: [
      Text(
        'Name:',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: Dimens.getDimen(15),
        ),
      ),
      const Spacer(),
      Text(
        user.username,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: Dimens.getDimen(15),
        ),
      ),
    ],
  );
}

Widget _createdAt(BuildContext context, UserModel user) {
  return Row(
    children: [
      Text(
        'Created_At:',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: Dimens.getDimen(15),
        ),
      ),
      const Spacer(),
      Text(
        DateFormat('yMMMd').format(user.createdAt!).toString() ?? "",
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: Dimens.getDimen(15),
        ),
      ),
    ],
  );
}
