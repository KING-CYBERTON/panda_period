import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_period/auth/GetAuth.dart';
import 'package:panda_period/auth/Login.dart';
import 'package:panda_period/auth/signIn.dart';
import 'package:panda_period/pages/account.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "panda period",
      // useInheritedMediaQuery: true,                                                                                                  
      // locale: DevicePrev iew.locale(context),
      // builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      getPages: [
      
      GetPage(name: '/login', page: () => const LoginInPage() ),
      GetPage(name: '/signup', page: ()=> const SignUpPage() ),
      GetPage(name: '/Profile', page: () => const AccontProfile() ),
    // GetPage(name: '/Info', page: ()=> const InfoForm() ),
      ],
      initialRoute: '/login',
      //home: const ProfileScreen(),
    );
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp().then((value) => Get.put(GetAuth()));
  runApp(
    MyApp(),
  );
}

