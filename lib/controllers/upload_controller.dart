import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadController extends GetxController with PrintLogMixin {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final Uuid uuid = Uuid();
  final ImagePicker _picker = ImagePicker();

  Rx<File> _imageFile = Rx<File>();
  Rx<PickedFile> _imagePickFile = Rx<PickedFile>();
  Rx<dynamic> _pickImageError = Rx<dynamic>();

  Rx<File> get imageFile => _imageFile;
  void setImageFile(File file) => _imageFile.value = file;

  Rx<PickedFile> get imagePickFile => _imagePickFile;
  void setImagePickFile(PickedFile file) => _imagePickFile.value = file;

  Rx<dynamic> get pickImageError => _pickImageError;
  void setPickImageError(dynamic err) => _pickImageError.value = err;

  String bytesTransferred(StorageTaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalByteCount}';
  }

  Widget previewImage() {
    if (!imageFile.value.isNullOrBlank) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Image.file(
            imageFile.value,
            width: 200,
            height: 200,
          ),
        ),
      );
    } else if (pickImageError.value != null) {
      return Text(
        'Pick image error: ${pickImageError.value}',
        textAlign: TextAlign.center,
      );
    } else {
      return SizedBox();
    }
  }

  Future<StorageTaskSnapshot> uploadFile({File file, String uid}) async {
    // Generate a v1 (time-based) id
    String id = uuid.v1();

    final StorageReference photoRef =
        storage.ref().child('photos').child(uid).child(id);

    final StorageUploadTask uploadTask = photoRef.putFile(
        file,
        StorageMetadata(
          contentLanguage: 'en',
          customMetadata: <String, String>{'photoId': id},
        ));

    StorageTaskSnapshot taskSnap = await uploadTask.onComplete;
    return taskSnap;
  }

  Future<void> deleteFile({String uid, String photoId}) async {
    final StorageReference photoRef =
        storage.ref().child('photos').child(uid).child(photoId);

    await photoRef.delete();
  }

  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final PickedFile pickedFile = await _picker.getImage(
        source: source,
      );
      print(pickedFile.path);

      if (pickedFile != null) {
        setImageFile(File(pickedFile.path));
        setImagePickFile(pickedFile);
      }
    } catch (e) {
      setPickImageError(e);
    }
  }
}
