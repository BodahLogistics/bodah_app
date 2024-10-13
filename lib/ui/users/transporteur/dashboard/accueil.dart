import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../colors/color.dart';
import '../../../../modals/actualite.dart';
import '../../../../modals/users.dart';
import '../../../../providers/api/api_data.dart';
import 'index.dart';

class TransporteurDashboard extends StatelessWidget {
  const TransporteurDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final api_provider = Provider.of<ApiProvider>(context);
    Users? user = api_provider.user;
    List<Actualites> actualites = api_provider.actualites;

    Future<void> refreshActualites() async {
      await api_provider.InitActualites();
    }

    return Scaffold(
      backgroundColor: user!.dark_mode == 1 ? MyColors.secondDark : null,
      body: Stack(
        children: [
          RefreshIndicator(
            color: MyColors.secondary,
            onRefresh: refreshActualites,
            child: SingleChildScrollView(
              physics:
                  AlwaysScrollableScrollPhysics(), // Assure le défilement même si le contenu est petit
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 60),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Bienvenue ${user.name}",
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
                                    options: CarouselOptions(
                                      height: 200,
                                      aspectRatio: 16 / 9,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 8),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      viewportFraction: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 20),
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
                      padding: const EdgeInsets.only(top: 35),
                      child: ElevatedButton(
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
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          // CircularProgressIndicator centré pendant le chargement
        ],
      ),
    );
  }
}
