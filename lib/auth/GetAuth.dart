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
  //with this calback function we are now done with the authntication
  //this means we can now effective chack if the user is logged in or not
  // and react ro the results effectivelly

}

//with that done we are going to create  a function to create a user in firebasea auth
// do to a small recap we are creating a user with email and password
void  CreateUser(String email,password)async{
  //now we have a helper function for creating a user iin firebase auth
  //but wait we have to take account of the all possibilities
  //what are the posibilities: success or failer
  // to take this in to concideration we create a try catch
  try {
    await auth.createUserWithEmailAndPassword(email: email, password:password);
    //so we are trying to authenticate and if it fails we catch an error ang send a message
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
  //now we have a helper function for creating a user iin firebase auth
  //but wait we have to take account of the all possibilities
  //what are the posibilities: success or failer
  // to take this in to concideration we create a try catch
  try {
   await  auth.signInWithEmailAndPassword(email: email, password:password);
    //so we are trying to authenticate and if it fails we catch an error ang send a message
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