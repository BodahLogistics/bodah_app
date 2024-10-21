// ignore_for_file: prefer_final_fields, depend_on_referenced_packages, empty_catches

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../ui/auth/sign_in.dart';

class ProvDown extends ChangeNotifier {
  double _progress = 0.0;
  bool _affiche = false;
  Dio _dio = Dio();

  double get progress => _progress;
  bool get affiche => _affiche;

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();

  void reset_files() {
    _files_selected = [];
    notifyListeners();
  }

  Future<void> selectImageFromGallery(BuildContext context) async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _files_selected.clear();
        String extension = path.extension(pickedFile.path).toLowerCase();
        List<String> allowedExtensions = ['.jpeg', '.jpg', '.png', '.gif'];
        if (allowedExtensions.contains(extension)) {
          File resizedFile = await resizeImage(File(pickedFile.path));
          _files_selected.add(resizedFile);
          showCustomSnackBar(
              context, "Image sélectionné avec succès", Colors.green);
        } else {
          showCustomSnackBar(
              context,
              "Seuls les fichiers JPEG, JPG, PNG et GIF sont autorisés.",
              Colors.redAccent);
        }
      } else {
        showCustomSnackBar(
            context, "Aucuen image selectionnée", Colors.redAccent);
      }

      notifyListeners();
    } catch (e) {}
  }

  List<File> _files_selected = [];
  List<File> get files_selected => _files_selected;

  Future<File> resizeImage(File file) async {
    final bytes = await file.readAsBytes();
    img.Image image = img.decodeImage(bytes)!;
    img.Image resizedImage = img.copyResize(image, width: 800, height: 800);
    final resizedFile = File(file.path);
    await resizedFile.writeAsBytes(img.encodeJpg(resizedImage));
    return resizedFile;
  }

  Future<void> startDownload(String fileUrl, String savePath) async {
    _affiche = true;
    _progress = 0.0;
    notifyListeners();

    try {
      await _dio.download(
        fileUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            _progress = received / total;
            notifyListeners();
          }
        },
      );
    } catch (e) {
      _affiche = false;
      notifyListeners();
    } finally {
      _affiche = false;
      notifyListeners();
    }
  }
}
