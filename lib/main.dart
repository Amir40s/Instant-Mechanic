import 'package:car_mechanics/helpers/colors.dart';
import 'package:car_mechanics/screens/start_screens/owner_start_screen/owner_start_provider/owner_start_provider.dart';
import 'package:car_mechanics/screens/start_screens/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context)=> const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
        builder: (context, orientation, screenType) {
          return MultiProvider(providers: [
            ChangeNotifierProvider(create: (context)=>OwnerStartProvider()),
          ],
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Car Mechanics',
              theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: appColor,primary: appColor)
              ),
              home: const SplashScreen(),
            ),
          );
        }
    );

  }
}

