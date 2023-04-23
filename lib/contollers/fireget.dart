import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_period/app2/usermodel.dart';
import 'package:panda_period/contollers/GetAuth.dart';



class FireRepo extends GetxController {

  static FireRepo instance = Get.find();
 


  

  final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  

  createUser(UserData user) async{
     await  _db.collection("Users").add(user.toJson())
    .whenComplete(() => Get.snackbar('success', 'Info has been updated',
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.greenAccent.withOpacity(0.2),
    colorText: Colors.black87),
    ).catchError((e){
      Get.snackbar('Error', 'Something went wrong',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent.withOpacity(0.2),
      colorText: Colors.black);
    }); 
    Get.toNamed('/Homescreen');
  }
 
  Future<UserData> getUserData(String email) async{
    final snapshot =await _db.collection('Users').where('email', isEqualTo: email).get();
    final userdetails = snapshot.docs.map((e) => UserData.fromSnapshot(e)).single;
    
    return userdetails;
    
  }

  Future<List<UserData>> allUser() async{
    final snapshot =await _db.collection('Users').get();
    final userdetails = snapshot.docs.map((e) => UserData.fromSnapshot(e)).toList();
    return userdetails;
    
  }





  

   


}
