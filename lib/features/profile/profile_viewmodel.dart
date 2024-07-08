import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flychat/data/repository/database_repository/database_repo_impl.dart';
import 'package:flychat/data/repository/database_repository/database_repository.dart';
import 'package:image_picker/image_picker.dart';

class ProfileNameViewmodel {
  final DatabaseRepository databaseRepository = DatabaseRepoImpl();
  final TextEditingController nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final ValueNotifier<File?> image = ValueNotifier<File?>(null);

  Future<void> onClickSubmitButton(BuildContext context) async {
    String name = nameController.text.trim();

    if (name.isNotEmpty && image.value != null) {
      try {
        final fileName = image.value!.path.split('/').last;
        final filePath = 'images/$fileName';

        final imageUrl = await databaseRepository.uploadPicture(image.value!, filePath);

        if (imageUrl != null) {
          bool response = await databaseRepository.insertDataIntoProfile(name, imageUrl);

          if (response) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload image')));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to get image URL')));
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred. Please try again.')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name or image is empty')));
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
