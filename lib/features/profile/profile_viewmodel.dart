import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flychat/Supabase/database_service/database_repo_impl.dart';
import 'package:flychat/Supabase/database_service/database_repository.dart';
import 'package:image_picker/image_picker.dart';

class ProfileNameViewmodel {
  DatabaseRepository databaseRepository = DatabaseRepoImpl();

  TextEditingController nameController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  ValueNotifier<File?> image = ValueNotifier(null);

  Future<void> onClickSubmitName(BuildContext context) async {
    String name = nameController.text;

    if (name.isNotEmpty && image.value != null) {
      final fileName = image.value!.path.split('/').last;
      final filePath = 'images/$fileName';

      final imageUrl =
          await databaseRepository.uploadPicture(image.value!, filePath);

      bool response =
          await databaseRepository.insertDataIntoProfile(name, imageUrl!);

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
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }
}
