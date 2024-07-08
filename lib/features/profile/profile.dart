import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flychat/features/profile/profile_viewmodel.dart';
import 'package:flychat/util/values/dimens.dart';

class ProfileName extends StatefulWidget {
  const ProfileName({super.key});

  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  final ProfileNameViewmodel viewmodel = ProfileNameViewmodel();

  @override
  void initState() {
    super.initState();
    // Add a listener to the image ValueNotifier to trigger a rebuild when it changes
    viewmodel.image.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose of the TextEditingController and remove the listener
    viewmodel.nameController.dispose();
    viewmodel.image.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

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
              const Spacer(flex: 2),
              Text(
                'Please enter your details',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: Dimens.getDimen(18),
                ),
              ),
              const Spacer(flex: 2),
              _imagePicker(context),
              const Spacer(flex: 2),
              _nameTextField(context),
              const Spacer(flex: 4),
              _submitButton(context),
              const Spacer(flex: 6),
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

  Widget _imagePicker(BuildContext context) {
    return ValueListenableBuilder<File?>(
      valueListenable: viewmodel.image,
      builder: (context, image, _) => Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipOval(
            child: image != null
                ? Image.file(
              image,
              width: Dimens.getDimen(140),
              height: Dimens.getDimen(140),
              fit: BoxFit.cover,
            )
                : Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpDqID8tFzQI6zdjODUNBO1gQjfrYtonjJRw&s',
              width: Dimens.getDimen(140),
              height: Dimens.getDimen(140),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => viewmodel.pickImage(),
              child: Container(
                width: Dimens.getDimen(30),
                height: Dimens.getDimen(30),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: Dimens.getDimen(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameTextField(BuildContext context) {
    return TextFormField(
      controller: viewmodel.nameController,
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
