// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_prefixes

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'colors/color.dart';
import 'functions/function.dart';
import 'providers/auth/prov_reset_password.dart';
import 'providers/auth/prov_sign_in.dart';
import 'providers/auth/prov_sign_up.dart';
import 'services/data_base_service.dart';
import 'ui/auth/sign_in.dart';
import 'wrappers/wrapper.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => Functions(),
        ),
        Provider(create: (_) => DBServices()),
        ChangeNotifierProvider(
          create: (context) => ProvSignIn(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvSignUp(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvResetPassword(),
        )
      ],
      child: MaterialApp(
        routes: {"/login": (context) => SignIn()},
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('fr', 'FR'),
        ],
        title: 'Bodah',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.secondary),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          splash: 'images/log.png',
          nextScreen: SignIn(),
          splashTransition: SplashTransition.fadeTransition,
        ),
      ),
    );
  }
}
