import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

FirebaseStorage fireStorage = FirebaseStorage.instance;

// Select an image from the gallery or take a picture with the camera
Future<void> fireUploadImage(String inputSource) async {
  final picker = ImagePicker();
  XFile? pickedImage;
  try {
    pickedImage = await picker.pickImage(
        source: inputSource == 'camera'
            ? ImageSource.camera
            : ImageSource.gallery,
        maxWidth: 1920);

    final String fileName = path.basename(pickedImage!.path);
    File imageFile = File(pickedImage.path);

    try {
      // Uploading the selected image with some custom meta data
      await fireStorage.ref(fileName).putFile(
          imageFile,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'A bad guy',
            'description': 'Some description...'
          }));
    } on FirebaseException catch (error) {
        print(error);
      }
  } catch (err) {
      print(err);
  }
}

Future<List<Map<String, dynamic>>> fireLoadFiles() async {
  List<Map<String, dynamic>> files = [];

  final ListResult result = await fireStorage.ref().list();
  final List<Reference> allFiles = result.items;

  await Future.forEach<Reference>(allFiles, (file) async {
    final String fileUrl = await file.getDownloadURL();
    final FullMetadata fileMeta = await file.getMetadata();
    files.add({
      "url": fileUrl,
      "path": file.fullPath,
      "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
      "description":
      fileMeta.customMetadata?['description'] ?? 'No description'
    });
  });

  return files;
}

Future<void> fireGetFilesList(String path) async {
  final ListResult result = await fireStorage.ref().list();
}

Future<void> fireDeleteFile(String ref) async {
  await fireStorage.ref(ref).delete();
}