import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flychat/auth_service/supabase_auth_servce.dart';
import 'package:image_picker/image_picker.dart';

class ProfileNameViewmodel {
  TextEditingController nameController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  ValueNotifier<File?> image = ValueNotifier(null);

  Future<void> onClickSubmitName(BuildContext context) async {
    String name = nameController.text;

    if (name.isNotEmpty && image.value != null) {
      final fileName = image.value!.path.split('/').last;
      final filePath = 'images/$fileName';

      final imageUrl = await SupabaseServce.uploadPicture(image.value!, filePath);

      bool response = await SupabaseServce.insertDataIntoProfile(name, imageUrl!);

      if (response) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        print('Failed to upload image');
      }
    } else {
      print('Name or image is empty');
    }
  }

  Future<void> pickImage() async {
    print('hello');
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }
}
