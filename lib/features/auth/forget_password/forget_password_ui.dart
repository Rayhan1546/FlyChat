import 'package:flutter/material.dart';
import 'package:flychat/features/auth/forget_password/forget_password_viewmodel.dart';
import 'package:flychat/features/values/dimens.dart';

class ForgetPasswordUi extends StatelessWidget {
  ForgetPasswordUi({super.key});

  ForgetPasswordViewmodel viewmodel = ForgetPasswordViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: Dimens.getDimen(20),
            right: Dimens.getDimen(20),
            top: Dimens.getDimen(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _backButton(context),
              const Spacer(
                flex: 3,
              ),
              Text(
                'Enter your valid email address to reset your Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: Dimens.getDimen(18),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              _nameTextField(context),
              const Spacer(
                flex: 4,
              ),
              _submitButton(context),
              const Spacer(
                flex: 6,
              ),
            ],
          ),
        ),
      ),
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

  Widget _nameTextField(BuildContext context) {
    return TextFormField(
      controller: viewmodel.emailController,
      decoration: const InputDecoration(
        labelText: 'Your name',
        labelStyle: TextStyle(fontSize: 20),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimens.getDimen(50),
      child: ElevatedButton(
        onPressed: () => viewmodel.onClickSubmitButton(context),
        child: const Text('Submit'),
      ),
    );
  }
}
