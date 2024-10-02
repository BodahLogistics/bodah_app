// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProvConnexion with ChangeNotifier {
  bool _isConnected = true;
  late StreamSubscription<InternetConnectionStatus> _subscription;
  Timer? _timer;

  ProvConnexion() {
    // Vérification initiale
    checkInitialConnection();

    // Écoute les changements de connexion en temps réel
    _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      _isConnected = (status == InternetConnectionStatus.connected);
      notifyListeners(); // Notifie les widgets abonnés quand le statut change
    });

    // Vérification périodique de l'état de la connexion toutes les 10 secondes
    _startPeriodicCheck();
  }

  bool get isConnected => _isConnected;

  // Vérifie l'état de la connexion au démarrage
  Future<void> checkInitialConnection() async {
    _isConnected = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  // Démarre un timer pour vérifier la connexion périodiquement
  void _startPeriodicCheck() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      bool currentStatus = await InternetConnectionChecker().hasConnection;
      if (currentStatus != _isConnected) {
        _isConnected = currentStatus;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    // Annule les abonnements et le timer lorsque le Provider est détruit
    _subscription.cancel();
    _timer?.cancel();
    super.dispose();
  }
}
