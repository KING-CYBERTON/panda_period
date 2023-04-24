import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class GetAuth extends GetxController {
  


  static GetAuth instance =Get.find();
  

  //late Rx<User?> _user;
    Rxn<User> fbUser = Rxn<User>();
  final googleSignIn = GoogleSignIn();
  
  FirebaseAuth auth =FirebaseAuth.instance;
  GoogleSignInAccount? _googleAcc;
  
 

  
@override
void onReady(){
  super.onReady();
  
  fbUser= Rxn<User>(auth.currentUser);
 
  fbUser.bindStream(auth.userChanges());
 
  ever(fbUser, _initialScreen);

}


_initialScreen(User? user){
  if(user==null){
    print('loged in');
    Get.offAllNamed('/login');
  }
  else{
    print(user.uid);
Get.offAllNamed('/Homescreen');
  }
  
        
}




void  createUser(String email,password)async{

  try {
    await auth.createUserWithEmailAndPassword(email: email, password:password);
  
  } catch (e) {
  // we will display the message uing the getx snack bar
    print(e.toString());
    Get.snackbar("user info", "user message",
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.TOP,
    titleText:const Text("account creation failed", style: TextStyle(color: Colors.white),),
    );
    
  }
 
}

void  logInUser(String email,password) async{
 
  try {
   await  auth.signInWithEmailAndPassword(email: email, password:password);

  } catch (e) {
  // we will display the message uing the getx snack bar
    print(e.toString());
    Get.snackbar("user info", "user message",
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.TOP,
    titleText:const Text("account Login failed", style: TextStyle(color: Colors.white),),
    );
    
  }
 
}
void logOut(){
  auth.signOut();

}
 





}

