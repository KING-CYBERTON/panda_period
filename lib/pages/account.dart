//import 'dart:html';

// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panda_period/contollers/GetAuth.dart';
import 'package:panda_period/contollers/UserFech.dart';
import 'package:panda_period/contraints/accContainers.dart';

class AccontProfile extends StatefulWidget {
  
  const AccontProfile({super.key});

  @override
  State<AccontProfile> createState() => _AccontProfileState();
}

class _AccontProfileState extends State<AccontProfile> {
  
  var plController = TextEditingController();
  var ClController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Panda Account'),
        
      ),
      body:SingleChildScrollView(
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [

          BoxShadow(
            blurRadius: 10,
            offset: Offset(1, 1),
            color: Colors.grey,
          )
        ],
        border: Border.all(
          color: Color.fromARGB(255, 11, 12, 10),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
              alignment: Alignment.center,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(height: 90,),
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('panda.png'),

                  ),
                  SizedBox(height: 30,),
                  
                  // ignore: prefer_const_constructors
                  customContainer(
                    label: 'Name:',
                    txt: 'data',
                    txtColor: Colors.black87,
                    weight: FontWeight.w500,
                    size: 30,
                    style: FontStyle.italic),
                    const SizedBox(height: 30,),
                    customContainer(
                    label: 'email:',
                    txt: 'data',
                    txtColor: Colors.black87,
                    weight: FontWeight.w500,
                    size: 30,
                    style: FontStyle.italic),
                    const SizedBox(height: 30,),
                    customContainer(
                    label: 'cycle length:',
                    txt: 'data',
                    txtColor: Colors.black87,
                    weight: FontWeight.w500,
                    size: 30,
                    style: FontStyle.italic),
                    const SizedBox(height: 30,),
                    customContainer(
                    label: 'period length:',
                    txt: 'data',
                    txtColor: Colors.black87,
                    weight: FontWeight.w500,
                    size: 30,
                    style: FontStyle.italic),
                     const SizedBox(height: 200,),
                ElevatedButton(onPressed: (){
                  GetAuth.instance.LogOut();
                },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shadowColor: Color.fromARGB(26, 81, 160, 180),
            ),
             child: Text(
                'Log out',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.lightGreen[800],
                ),
              ),),
              const SizedBox(height: 60,),
                ],
              ),
              ))
              ]
              )
              )
    );
  }
}