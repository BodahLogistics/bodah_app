// ignore_for_file: non_constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages, empty_catches

import 'dart:io';

import 'package:bodah/modals/pays.dart';
import 'package:bodah/modals/villes.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../../../services/data_base_service.dart';
import '../../../../modals/type_camions.dart';
import '../../../../ui/auth/sign_in.dart';

class ProvAddChauffeur with ChangeNotifier {
  final apiService = DBServices();
  bool _upload = false;
  bool get upload => _upload;
  void change_upload(bool value) {
    _upload = value;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();

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

  void reset_profil() {
    _profil = [];
    notifyListeners();
  }

  List<File> _files_selected = [];
  List<File> get files_selected => _files_selected;

  List<File> _file2 = [];
  List<File> get file2 => _file2;

  List<File> _file3 = [];
  List<File> get file3 => _file3;

  List<File> _profil = [];
  List<File> get profil => _profil;

  Future<File> resizeImage(File file) async {
    final bytes = await file.readAsBytes();
    img.Image image = img.decodeImage(bytes)!;
    img.Image resizedImage = img.copyResize(image, width: 800, height: 800);
    final resizedFile = File(file.path);
    await resizedFile.writeAsBytes(img.encodeJpg(resizedImage));
    return resizedFile;
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

      notifyListeners();
    } catch (e) {}
  }

  Future<void> takeImageWithCamera(BuildContext context) async {
    try {
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

      notifyListeners();
    } catch (e) {}
  }

  Future<void> selectFile2FromGallery(BuildContext context) async {
    try {
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

      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  Future<void> takeFile2WithCamera(BuildContext context) async {
    try {
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

      notifyListeners();
    } catch (e) {}
  }

  Future<void> selectFile3FromGallery(BuildContext context) async {
    try {
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

      notifyListeners();
    } catch (e) {}
  }

  Future<void> takeFile3WithCamera(BuildContext context) async {
    try {
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

      notifyListeners();
    } catch (e) {}
  }

  Future<void> selectProfilFromGallery(BuildContext context) async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _profil.clear();
        String extension = path.extension(pickedFile.path).toLowerCase();
        List<String> allowedExtensions = ['.jpeg', '.jpg', '.png', '.gif'];
        if (allowedExtensions.contains(extension)) {
          File resizedFile = await resizeImage(File(pickedFile.path));
          _profil.add(resizedFile);
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

      notifyListeners();
    } catch (e) {}
  }

  Future<void> takeProfilWithCamera(BuildContext context) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        String extension = path.extension(pickedFile.path).toLowerCase();
        List<String> allowedExtensions = ['.jpeg', '.jpg', '.png', '.gif'];

        if (allowedExtensions.contains(extension)) {
          File resizedFile = await resizeImage(File(pickedFile.path));
          _profil.clear();
          _profil.add(resizedFile);
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

      notifyListeners();
    } catch (e) {}
  }

  void reset() {
    _villes = [];
    _profil = [];
    _files_selected = [];
    _file2 = [];
    _file3 = [];
    _pay = Pays(id: 24, name: "");
    _ville = Villes(id: 9626, name: "", country_id: 0);
    _name = "";
    _telepehone = "";
    _permis = "";
    _imm = "";
    _type_camion = TypeCamions(id: 0, nom: "");
    _adresse = "";
    _email = "";
    _affiche = false;
    notifyListeners();
  }

  String _imm = "";
  String _adresse = "";
  String _email = "";
  String _permis = "";
  String _telepehone = "";
  String _name = "";
  List<Villes> _villes = [];
  Villes _ville = Villes(id: 0, name: "", country_id: 0);
  Pays _pay = Pays(id: 24, name: "");
  TypeCamions _type_camion = TypeCamions(id: 0, nom: "");
  TypeCamions get type_camion => _type_camion;

  bool _affiche = false;

  String get imm => _imm;
  String get permis => _permis;
  String get telephone => _telepehone;
  String get name => _name;

  List<Villes> get villes => _villes;
  String get adresse => _adresse;
  String get email => _email;
  Pays get pay => _pay;
  Villes get ville => _ville;
  bool get affiche => _affiche;

  void change_type_camion(TypeCamions type_camion) {
    _type_camion = type_camion;
    notifyListeners();
  }

  Future<void> getAllVilles(int country_id) async {
    final response = await apiService.getVilles(country_id);
    _villes = response;
    notifyListeners();
  }

  void change_adresse(String? value) {
    _adresse = value!;
    notifyListeners();
  }

  void change_email(String? value) {
    _email = value!;
    notifyListeners();
  }

  void change_pays(Pays pay) {
    _pay = pay;
    notifyListeners();
  }

  void change_ville(Villes ville) {
    _ville = ville;
    notifyListeners();
  }

  void change_affiche(bool value) {
    _affiche = value;
    notifyListeners();
  }

  void change_name(String? value) {
    _name = value!;
    notifyListeners();
  }

  void change_telephone(String? value) {
    _telepehone = value!;
    notifyListeners();
  }

  void change_permis(String? value) {
    _permis = value!;
    notifyListeners();
  }

  void change_imm(String? value) {
    _imm = value!;
    notifyListeners();
  }
}
