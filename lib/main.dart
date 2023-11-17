import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsic/Providers/progress_indicator.dart';
import 'package:nsic/Screens/Verification/intro_page.dart';
import 'package:nsic/Screens/Verification/verification_page.dart';
import 'package:flutter/services.dart';
import 'package:nsic/Utilities/networkBinding.dart';
import 'package:nsic/Utilities/theme_data.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((fn) => {
            runApp(
              ChangeNotifierProvider(
                create: (_) => ProgressIndicatorProvider(),
                child: MyApp(),
              ),
            ),
          });
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: NetworkBinding(),
      title: 'NSIC',
      theme: themeData.light,
      home: const IntroPage(),
      routes: {
        "/verify": (context) => VerificationPage(),
        "/intro":(context)=>IntroPage(),
        // "/screen1": (context) => Step1()
      },
    );
  }
}
