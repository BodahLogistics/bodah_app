// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_adjacent_string_concatenation, unnecessary_null_comparison

import 'package:bodah/colors/color.dart';
import 'package:bodah/modals/actualite.dart';
import 'package:bodah/ui/users/transporteur/dashboard/index.dart';
import 'package:bodah/wrappers/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../functions/function.dart';
import '../../../../modals/users.dart';
import '../../../../providers/api/api_data.dart';

class TransporteurDashboard extends StatefulWidget {
  const TransporteurDashboard({
    super.key,
  });

  @override
  State<TransporteurDashboard> createState() => _TransporteurDashboardState();
}

class _TransporteurDashboardState extends State<TransporteurDashboard> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).InitActualites();
  }

  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Actualites> actualites = api_provider.actualites;
    bool loading = api_provider.loading;
    final CarouselSliderController controller = CarouselSliderController();

    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      body: loading
          ? Loading()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 60),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Bienvenue " + user.name,
                        style: TextStyle(
                            color: user.dark_mode == 1
                                ? MyColors.light
                                : MyColors.black,
                            fontFamily: "Poppins",
                            fontSize: MediaQuery.of(context).size.width > 520
                                ? 20
                                : 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    actualites.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CarouselSlider(
                                    items: actualites.map((photo) {
                                      return Builder(
                                        builder: (context) {
                                          return Stack(
                                            children: [
                                              // Image en arrière-plan
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "https://test.bodah.bj/storage/${photo.path}",
                                                  fit: BoxFit.cover,
                                                  height: 200,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }).toList(),
                                    carouselController: controller,
                                    options: CarouselOptions(
                                      pauseAutoPlayOnManualNavigate: false,
                                      height: 200,
                                      aspectRatio: 16 / 9,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 8),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      pauseAutoPlayOnTouch: false,
                                      viewportFraction: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Text(
                        "Trouvez des cargements en temps réel avec Bodah",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: user.dark_mode == 1
                                ? MyColors.light
                                : Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "images/transp.png",
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 20),
                      child: Text(
                        "Planifiez paisiblement vos trajets et à l'avance avec Bodah",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: user.dark_mode == 1
                                ? MyColors.light
                                : MyColors.black,
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return WelcomeTransporteur();
                              },
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Commencez",
                          style: TextStyle(
                              color: MyColors.light,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}
