// ignore_for_file: non_constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../../../services/data_base_service.dart';

class ProvAddDoc with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final apiService = DBServices();
  void change_doc(String nom) {
    _nom = nom;
    notifyListeners();
  }

  void reset() {
    _files_selected = [];
    _nom = "";
    _affiche = false;
    notifyListeners();
  }

  List<File> _files_selected = [];
  List<File> get files_selected => _files_selected;
  void change_files(List<File> files) {
    _files_selected = files;
    notifyListeners();
  }

  bool _upload = false;
  bool get upload => _upload;
  void change_upload(bool value) {
    _upload = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  void change_loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> selectImagesFromGallery(BuildContext context) async {
    try {
      _upload = true;
      notifyListeners(); // Notifie les écouteurs que l'état a changé

      if (_files_selected.length > 2) {
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Vous devez ajouter qu'un seul fichier",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins"),
          ),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _upload = false;
        notifyListeners(); // Met à jour l'état pour indiquer que l'opération est terminée
        return;
      }

      final List<XFile>? pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles != null) {
        for (var pickedFile in pickedFiles) {
          if (_files_selected.length < 2) {
            String extension = path.extension(pickedFile.path).toLowerCase();
            List<String> allowedExtensions = ['.jpeg', '.jpg', '.png', '.gif'];

            if (allowedExtensions.contains(extension)) {
              File resizedFile = await resizeImage(File(pickedFile.path));
              _files_selected.add(resizedFile);
              notifyListeners(); // Notifie que la liste des fichiers a changé
            } else {
              final snackBar = SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  "Seuls les fichiers JPEG, JPG, PNG et GIF sont autorisés.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                ),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              continue; // Continue l'itération sans ajouter le fichier non valide
            }
          } else {
            break;
          }
        }

        final snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Images ajoutées avec succès",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins"),
          ),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Aucune image selectionnée",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins"),
          ),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      _upload = false;
      notifyListeners(); // Met à jour l'état après l'opération
    } catch (e) {
      _upload = false;
      notifyListeners(); // Notifie en cas d'erreur
    }
  }

  Future<void> takeImageWithCamera(BuildContext context) async {
    try {
      _loading = true;
      notifyListeners(); // Notifie que le chargement commence

      if (_files_selected.length > 2) {
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Vous devez ajouter qu'un seul fichier",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins"),
          ),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _loading = false;
        notifyListeners(); // Met à jour l'état après l'erreur
        return;
      }

      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        String extension = path.extension(pickedFile.path).toLowerCase();
        List<String> allowedExtensions = ['.jpeg', '.jpg', '.png', '.gif'];

        if (allowedExtensions.contains(extension)) {
          File resizedFile = await resizeImage(File(pickedFile.path));
          _files_selected.add(resizedFile);
          notifyListeners(); // Notifie que la liste des fichiers a changé

          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Image ajoutée avec succès",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins"),
            ),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Seuls les fichiers JPEG, JPG, PNG et GIF sont autorisés.",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins"),
            ),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Aucune image selectionnée",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins"),
          ),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      _loading = false;
      notifyListeners(); // Met à jour l'état après l'opération
    } catch (e) {
      _loading = false;
      notifyListeners(); // Notifie en cas d'erreur
    }
  }

  Future<File> resizeImage(File file) async {
    final bytes = await file.readAsBytes();
    img.Image image = img.decodeImage(bytes)!;

    // Redimensionne l'image à 800x800 pixels (ou n'importe quelle taille que tu préfères)
    img.Image resizedImage = img.copyResize(image, width: 800, height: 800);

    final resizedFile = File(file.path);
    await resizedFile.writeAsBytes(img.encodeJpg(resizedImage));
    return resizedFile;
  }

  String _nom = "";

  void change_nom(String? value) {
    _nom = value!;
    notifyListeners();
  }

  bool _affiche = false;
  String get nom => _nom;
  bool get affiche => _affiche;

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }
}
