import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void LanguageDialogBoxUi(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Select Language',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageButton(context, 'Bangla', false),
              _languageButton(context, 'English', true),
            ],
          ),
        );
      });
}

Widget _languageButton(BuildContext context, String language, bool isSelected) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      language,
      style:const TextStyle(color: Colors.white),
    ),
    trailing: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
  );
}
