import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panda_period/app2/home.dart';
import 'package:panda_period/app2/profile.dart';
import 'package:panda_period/app2/profile2.dart';
import 'package:panda_period/contollers/GetAuth.dart';
import 'package:panda_period/pages/Events.dart';
import 'package:panda_period/pages/Login.dart';
import 'package:panda_period/app2/account.dart';
import 'package:panda_period/pages/event.dart';
import 'package:panda_period/pages/signIn.dart';
import 'package:get/get.dart';


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
      GetPage(name: '/login', page: () => const LoginInPage() ),
      GetPage(name: '/signup', page: ()=> const SignUpPage() ),
      GetPage(name: '/Profile', page: () => const ProfileTab() ),
      GetPage(name: '/ProfileDisplay', page: () => const ProfileTabdisplay() ),
      GetPage(name: '/Homescreen', page: () => const HomePage() ),
     GetPage(name: '/calender', page: () => const eve() ),
      GetPage(name: '/PeriodEdit', page: () => const periodEditing()  ),
      GetPage(name: '/calender2', page: () =>  SfCalendarWidget()  ),
     
      
      
     GetPage(name: '/first', page: () => calenderwidget()  ),
      
      ],
      home:const LoginInPage(),
    );
  }
}


