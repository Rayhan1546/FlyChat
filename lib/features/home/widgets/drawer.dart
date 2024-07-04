import 'package:flutter/material.dart';
import 'package:flychat/features/values/dimens.dart';

bottomSheetUi(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.grey[800],
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          padding: EdgeInsets.all(Dimens.getDimen(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: Dimens.getDimen(22),
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Theme',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  Widget _themeSetting(BuildContext context) {
    return Column();
  }
}
