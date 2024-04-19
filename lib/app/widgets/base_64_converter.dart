import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class ImageConverter {
  static Future<String?> imageToBase64(String imagePath) async {
    try {
      File imageFile = File(imagePath);
      List<int> imageBytes = await imageFile.readAsBytes();

      String base64Image = base64Encode(imageBytes);
      return base64Image;
    } catch (e) {
      log("Error While Converting image to Base64: $e");
      return null;
    }
  }

  static ImageProvider base64ToImage(String base64) {
      while(base64.length % 4 != 0){
        base64 += '=';
      }
      Uint8List bytes = base64Decode(base64);
      return MemoryImage(bytes);
  }
}