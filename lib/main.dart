import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panda_period/app2/home.dart';
import 'package:panda_period/app2/Form.dart';
import 'package:panda_period/app2/splah.dart';
import 'package:panda_period/contollers/GetAuth.dart';

import 'package:panda_period/pages/Login.dart';

import 'package:panda_period/pages/signIn.dart';
import 'package:get/get.dart';

import 'app2/Form.dart';


void main()  async{
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp().then((value) => Get.put(GetAuth()));
  runApp
  (const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)   {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      getPages: [
        GetPage(name: '/', page: () => SplashScreen() ),
      GetPage(name: '/login', page: () => const LoginInPage() ),
      GetPage(name: '/signup', page: ()=> const SignUpPage() ),
      GetPage(name: '/Profile', page: () => const ProfileTab() ),
      GetPage(name: '/Homescreen', page: () => const HomePage() ),
      
     
      
      ],
      initialRoute: '/',
    );
  }
}


