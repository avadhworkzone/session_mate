<<<<<<< Updated upstream
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileViewModel extends GetxController{

  Rx<TextEditingController> editProfileNameController = TextEditingController().obs;

=======
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileViewModel extends GetxController{

  Rx<TextEditingController> editProfileNameController = TextEditingController().obs;
  Rx<TextEditingController> editProfileEmailController = TextEditingController().obs;
  Rx<File> imgFile = File('').obs;

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();

    /// FOR PIC IMAGE FROM GALLERY
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      // newImage.value = pickedFile.path;
      imgFile.value = File(pickedFile.path);

      /// FOR HIDING BOTTOM SHEET
      Get.back();
    }
  }

  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();

    /// FOR PIC IMAGE FROM CAMERA
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedFile != null) {
      // newImage.value = pickedFile.path;
      imgFile.value = File(pickedFile.path);

      /// FOR HIDING BOTTOM SHEET
      Get.back();
    }
  }

>>>>>>> Stashed changes
}