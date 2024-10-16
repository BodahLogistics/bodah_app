// ignore_for_file: prefer_final_fields

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
