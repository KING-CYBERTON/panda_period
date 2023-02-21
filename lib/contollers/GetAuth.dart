import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GetAuth extends GetxController {


  static GetAuth instance =Get.find();

  late Rx<User?> _user;


  FirebaseAuth auth =FirebaseAuth.instance;

  
@override
void onReady(){
  super.onReady();
  
  _user= Rx<User?>(auth.currentUser);
 
  _user.bindStream(auth.userChanges());
 
  ever(_user, _initialScreen);

}


_initialScreen(User? user){
  if(user==null){
    print('login in');
    Get.offAllNamed('/login');
  }
  else{
Get.offAllNamed('/Profile');
  }
  

}


void  CreateUser(String email,password)async{

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

void  LogInUser(String email,password) async{
 
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
void LogOut(){
  auth.signOut();

}
  Google_auth () async{
  final GoogleSignInAccount? googleUser =await GoogleSignIn(
    scopes: <String>['email']).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,);

    return await auth.signInWithCredential(credential);
}





}