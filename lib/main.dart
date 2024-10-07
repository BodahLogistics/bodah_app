// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_prefixes, unnecessary_null_comparison, deprecated_member_use, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bodah/modals/rules.dart';
import 'package:bodah/modals/visiteurs.dart';
import 'package:bodah/providers/api/api_data.dart';
import 'package:bodah/providers/api/download.dart';
import 'package:bodah/providers/auth/prov_logout.dart';
import 'package:bodah/providers/auth/prov_val_account.dart';
import 'package:bodah/providers/calculator/index.dart';
import 'package:bodah/providers/connection/index.dart';
import 'package:bodah/providers/documents/appele.dart';
import 'package:bodah/providers/users/expediteur/drawer/index.dart';
import 'package:bodah/providers/users/expediteur/export/home.dart';
import 'package:bodah/providers/users/expediteur/import/aerien/add.dart';
import 'package:bodah/providers/users/expediteur/import/docs/add.dart';
import 'package:bodah/providers/users/expediteur/import/home.dart';
import 'package:bodah/providers/users/expediteur/import/liv/add.dart';
import 'package:bodah/providers/users/expediteur/import/march/add.dart';
import 'package:bodah/providers/users/expediteur/import/maritime/add.dart';
import 'package:bodah/providers/users/expediteur/import/transp/add.dart';
import 'package:bodah/providers/users/expediteur/marchandises/annoces/add.dart';
import 'package:bodah/providers/users/expediteur/marchandises/annoces/marchandises/add.dart';
import 'package:bodah/providers/users/expediteur/marchandises/annoces/odres/add.dart';
import 'package:bodah/providers/users/expediteur/marchandises/prov_dash_march.dart';
import 'package:bodah/providers/users/transporteur/annonces/home.dart';
import 'package:bodah/providers/users/transporteur/chauffeurs/add.dart';
import 'package:bodah/providers/users/transporteur/dashboard/prov_change.dart';
import 'package:bodah/providers/users/transporteur/drawer/index.dart';
import 'package:bodah/providers/users/transporteur/trajets/add.dart';
import 'package:bodah/providers/users/transporteur/trajets/camions/add.dart';
import 'package:bodah/ui/account/account_deleted.dart';
import 'package:bodah/ui/account/account_disabled.dart';
import 'package:bodah/ui/auth/sign_up.dart';
import 'package:bodah/wrappers/wrapper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'apis/bodah/infos.dart';
import 'colors/color.dart';
import 'functions/function.dart';
import 'modals/users.dart';
import 'providers/auth/prov_reset_password.dart';
import 'providers/auth/prov_sign_in.dart';
import 'providers/auth/prov_sign_up.dart';
import 'providers/users/expediteur/export/aerien/add.dart';
import 'providers/users/expediteur/export/maritime/add.dart';
import 'providers/users/expediteur/export/routes/add.dart';
import 'providers/users/expediteur/import/routes/add.dart';
import 'providers/users/expediteur/marchandises/annoces/details/home.dart';
import 'providers/users/expediteur/marchandises/nav_bottom/index.dart';
import 'services/data_base_service.dart';
import 'services/location _foreground_service.dart';
import 'services/secure_storage.dart';
import 'ui/auth/sign_in.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

Future<void> fetchLocationAndUserInfo() async {
  try {
    final apiService = DBServices();
    SecureStorage secure = SecureStorage();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      String deviceModel = '';

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceModel = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceModel = iosInfo.model;
      } else {
        deviceModel = 'Unknown';
      }

      String? userJson = await secure.readSecureData('user');
      String? ruleJson = await secure.readSecureData('rule');
      String? visiteurJson = await secure.readSecureData('visiteur');
      Users? user;
      Rules? rule;
      Visiteurs? visiteur;

      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        Users userData = Users.fromMap(userMap);
        user = userData;
      }

      if (ruleJson != null) {
        Map<String, dynamic> ruleMap = jsonDecode(ruleJson);
        Rules ruleData = Rules.fromMap(ruleMap);
        rule = ruleData;
      }

      if (visiteurJson != null) {
        Map<String, dynamic> visiteurMap = jsonDecode(visiteurJson);
        Visiteurs visiteurData = Visiteurs.fromMap(visiteurMap);
        visiteur = visiteurData;
      }

      if ((user != null && rule != null) || visiteur != null) {
        if (user != null && rule != null) {
          await apiService.createUserLocation(deviceModel, position.longitude,
              position.latitude, "", "", user.id);
        }
      } else {
        await apiService.createVisiteur(
            deviceModel, position.longitude, position.latitude, "", "");
      }
    }
  } catch (e) {}
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await fetchLocationAndUserInfo();
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Initializing WorkManager'); // Debug
  await Workmanager().initialize(callbackDispatcher);
  print('WorkManager initialized'); // Debug

  await Workmanager().registerPeriodicTask(
    "1",
    "localisation",
    frequency: Duration(minutes: 15),
    initialDelay: const Duration(seconds: 60),
    inputData: <String, dynamic>{},
    constraints: Constraints(networkType: NetworkType.connected),
  );

  runApp(MyApp());
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
        Provider(
          create: (_) => ApiInfos(),
        ),
        Provider(create: (_) => SecureStorage()),
        Provider(create: (_) => DBServices()),
        Provider(create: (_) => LocationForegroundService()),
        ChangeNotifierProvider(
          create: (context) => ProvSignIn(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvSignUp(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvResetPassword(),
        ),
        ChangeNotifierProvider<ApiProvider>(
          create: (_) => ApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvValiAccount(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvDrawExpediteur(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvLogOut(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvNavMarchBottomExp(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvChangeDashMarch(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvPublishAnnonce(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvCalculator(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvDownloadDocument(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddOrdre(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddMarchandise(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddImport(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddExport(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddImportMaritime(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddExportMaritime(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddImportAerien(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddExportAerien(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddMarch(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddTransp(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddMarchandise(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddLiv(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvHoImport(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddDoc(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvDown(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvHoExport(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvHoAnn(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvDrawTransporteur(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvDashTransp(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddTrajet(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddCamion(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvAddChauffeur(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvHoTransp(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvConnexion(),
        ),
      ],
      child: MaterialApp(
        routes: {
          "/login": (context) => SignIn(),
          "/register": (context) => SignUp(),
          "/disable": (context) => AccountDisabled(),
          "/delete": (context) => AccountDeleted()
        },
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
          nextScreen: Wrappers(),
          splashTransition: SplashTransition.fadeTransition,
        ),
      ),
    );
  }
}
