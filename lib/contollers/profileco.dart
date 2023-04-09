import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_period/contollers/fireget.dart';

import 'GetAuth.dart';

class userprofile extends GetxController {

  final _authrepo = Get.put(GetAuth());
  final _fire = Get.put(FireRepo());

    getUserDetails(){
    final email = _authrepo.fbUser.value?.email;
    if(email != null){
      return _fire.getUserData(email);
    }else{
      Get.snackbar('Error', 'Login to continue',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.black87  );
    }
  }



  
}