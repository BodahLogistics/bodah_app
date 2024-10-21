// ignore_for_file: override_on_non_overriding_member, must_be_immutable, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:bodah/functions/function.dart';
import 'package:bodah/providers/api/api_data.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../colors/color.dart';
import '../../../../../modals/expeditions.dart';
import '../../../../../modals/gps.dart';
import '../../../../../modals/transporteurs.dart';
import '../../../../../modals/users.dart';
import '../../../transporteur/drawer/index.dart';

class LocationCamion extends StatefulWidget {
  LocationCamion({super.key, required this.chargement_id});
  final int chargement_id;

  @override
  State<LocationCamion> createState() => _LocationCamionState();
}

class _LocationCamionState extends State<LocationCamion> {
  @override
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitGps();
  }

  late GoogleMapController mapController;

  // Coordonnées par défaut (Tour Eiffel)
  final LatLng _defaultPosition = LatLng(48.8584, 2.2945);

  late LatLng _initialPosition;

  late LatLng _markerPosition;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Expeditions> expeditions = api_provider.expeditions;
    Expeditions expedition =
        function.expedition(expeditions, widget.chargement_id);
    List<Gps> gps = api_provider.gps;
    List<Transporteurs> transporteurs = api_provider.transporteurs;

    List<Users> users = api_provider.users;
    Transporteurs transporteur =
        function.transporteur(transporteurs, expedition.transporteur_id);
    Users chauffeur = function.user(users, transporteur.user_id);

    Gps location = function.location(gps, chauffeur.id, "User");

    if (location.id != 0) {
      _initialPosition = LatLng(location.lat, location.long);
      _markerPosition = LatLng(location.lat, location.long);
    } else {
      _initialPosition = _defaultPosition;
      _markerPosition = _defaultPosition;
    }

    Future<void> refresh() async {
      await api_provider.InitTransporteurExpedition();
    }

    return Scaffold(
      drawer: DrawerTransporteur(),
      appBar: AppBar(
        backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
        iconTheme: IconThemeData(
            color: user.dark_mode == 1 ? MyColors.light : Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Position du camion",
          style: TextStyle(
              color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
              fontSize: 14),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: user.dark_mode == 1 ? MyColors.light : Colors.black,
              ))
        ],
      ),
      body: RefreshIndicator(
        color: MyColors.secondary,
        onRefresh: refresh,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target:
                _initialPosition, // Position basée sur la localisation ou par défaut
            zoom: 14.0,
          ),
          markers: {
            Marker(
              markerId: MarkerId('camion_position'),
              position: _markerPosition, // Position du marqueur
              infoWindow: InfoWindow(
                title: 'Position Actuelle',
                snippet: location.id != 0
                    ? 'Camion à cette position'
                    : 'Coordonnées par défaut',
              ),
            ),
          },
        ),
      ),
    );
  }
}
