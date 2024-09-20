// ignore_for_file: non_constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';

import 'package:bodah/modals/type_camions.dart';
import 'package:bodah/ui/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ProvAddCamion with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  List<File> _files_selected = [];
  List<File> get files_selected => _files_selected;

  List<File> _file2 = [];
  List<File> get file2 => _file2;

  List<File> _file3 = [];
  List<File> get file3 => _file3;

  bool _upload = false;
  bool get upload => _upload;
  void change_upload(bool value) {
    _upload = value;
    notifyListeners();
  }

  void reset_files() {
    _files_selected = [];
    notifyListeners();
  }

  void reset_file2() {
    _file2 = [];
    notifyListeners();
  }

  void reset_file3() {
    _file3 = [];
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  void change_loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> selectImageFromGallery(BuildContext context) async {
    try {
      _upload = true;
      notifyListeners();
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
              context, "Image ajoutée avec succès", Colors.green);
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

      _upload = false;
      notifyListeners();
    } catch (e) {
      _upload = false;
      notifyListeners();
    }
  }

  Future<void> takeImageWithCamera(BuildContext context) async {
    try {
      _upload = true;
      notifyListeners();
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        String extension = path.extension(pickedFile.path).toLowerCase();
        List<String> allowedExtensions = ['.jpeg', '.jpg', '.png', '.gif'];

        if (allowedExtensions.contains(extension)) {
          File resizedFile = await resizeImage(File(pickedFile.path));
          _files_selected.clear();
          _files_selected.add(resizedFile);
          showCustomSnackBar(
              context, "Image ajoutée avec succès", Colors.green);
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

      _upload = false;
      notifyListeners();
    } catch (e) {
      _upload = false;
      notifyListeners();
    }
  }

  Future<void> selectFile2FromGallery(BuildContext context) async {
    try {
      _upload = true;
      notifyListeners();
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _file2.clear();
        String extension = path.extension(pickedFile.path).toLowerCase();
        List<String> allowedExtensions = ['.jpeg', '.jpg', '.png', '.gif'];
        if (allowedExtensions.contains(extension)) {
          File resizedFile = await resizeImage(File(pickedFile.path));
          _file2.add(resizedFile);
          showCustomSnackBar(
              context, "Image ajoutée avec succès", Colors.green);
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

      _upload = false;
      notifyListeners();
    } catch (e) {
      _upload = false;
      notifyListeners();
    }
  }

  Future<void> takeFile2WithCamera(BuildContext context) async {
    try {
      _upload = true;
      notifyListeners();
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        String extension = path.extension(pickedFile.path).toLowerCase();
        List<String> allowedExtensions = ['.jpeg', '.jpg', '.png', '.gif'];

        if (allowedExtensions.contains(extension)) {
          File resizedFile = await resizeImage(File(pickedFile.path));
          _file2.clear();
          _file2.add(resizedFile);
          showCustomSnackBar(
              context, "Image ajoutée avec succès", Colors.green);
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

      _upload = false;
      notifyListeners();
    } catch (e) {
      _upload = false;
      notifyListeners();
    }
  }

  Future<void> selectFile3FromGallery(BuildContext context) async {
    try {
      _upload = true;
      notifyListeners();
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _file3.clear();
        String extension = path.extension(pickedFile.path).toLowerCase();
        List<String> allowedExtensions = ['.jpeg', '.jpg', '.png', '.gif'];
        if (allowedExtensions.contains(extension)) {
          File resizedFile = await resizeImage(File(pickedFile.path));
          _file3.add(resizedFile);
          showCustomSnackBar(
              context, "Image ajoutée avec succès", Colors.green);
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

      _upload = false;
      notifyListeners();
    } catch (e) {
      _upload = false;
      notifyListeners();
    }
  }

  Future<void> takeFile3WithCamera(BuildContext context) async {
    try {
      _upload = true;
      notifyListeners();
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        String extension = path.extension(pickedFile.path).toLowerCase();
        List<String> allowedExtensions = ['.jpeg', '.jpg', '.png', '.gif'];

        if (allowedExtensions.contains(extension)) {
          File resizedFile = await resizeImage(File(pickedFile.path));
          _file3.clear();
          _file3.add(resizedFile);
          showCustomSnackBar(
              context, "Image ajoutée avec succès", Colors.green);
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

      _upload = false;
      notifyListeners();
    } catch (e) {
      _upload = false;
      notifyListeners();
    }
  }

  Future<File> resizeImage(File file) async {
    final bytes = await file.readAsBytes();
    img.Image image = img.decodeImage(bytes)!;
    img.Image resizedImage = img.copyResize(image, width: 800, height: 800);
    final resizedFile = File(file.path);
    await resizedFile.writeAsBytes(img.encodeJpg(resizedImage));
    return resizedFile;
  }

  void reset() {
    _files_selected = [];
    _file2 = [];
    _file3 = [];
    _imm = "";
    _type_camion = TypeCamions(id: 0, nom: "");
    _affiche = false;
    notifyListeners();
  }

  String _imm = "";
  TypeCamions _type_camion = TypeCamions(id: 0, nom: "");
  TypeCamions get type_camion => _type_camion;
  bool _affiche = false;
  String get imm => _imm;
  bool get affiche => _affiche;

  void change_type_camion(TypeCamions type_camion) {
    _type_camion = type_camion;
    notifyListeners();
  }

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }

  void change_imm(String? value) {
    _imm = value!;
    notifyListeners();
  }
}
