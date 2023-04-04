import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:panda_period/contollers/UserFech.dart';
import 'package:panda_period/pages/event.dart';

class GetAuth extends GetxController {
  


  static GetAuth instance =Get.find();
  

  //late Rx<User?> _user;
    Rxn<User> fbUser = Rxn<User>();
  final googleSignIn = GoogleSignIn();
  
  FirebaseAuth auth =FirebaseAuth.instance;
  GoogleSignInAccount? _googleAcc;
  UserModel? _newUser;

  
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
Get.offAllNamed('/calender');
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
  final GoogleSignInAccount? googleUser =await GoogleSignIn().signIn();
  if (googleUser == null) return;


    _googleAcc = googleUser;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken, 
    idToken: googleAuth.idToken,);

    try {
      await auth.signInWithCredential(credential).then((res) async {
        print('Signed in successfully as ' + res.user!.displayName.toString());
        print('email: ' + res.user!.email.toString());}
        );
      
    } catch (e) {
      print(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
      
    } 
}










// }

// class PeriodList extends GetxController {

//   static PeriodList instance =Get.find();
// RxList<Period> periods=(List<Period>.of([])).obs; 
//   var count =0.obs;

//   @override
//   void onReady() {
//     // TODO: implement onReady
//     super.onReady();


//   }

//   loadData(String title, DateTime to,DateTime from, bool isAllday,Color background){

//     late Period PeriodModel=Period(title: title, from: from, to: to, background: background, isAllDay: true);
//     periods.value.add(PeriodModel);
//     count.value=periods.value.length;

//   }

// }

// //list of events in getx

// class  PeriodsList{
// RxList<Period> period=(List<Period>.of([])).obs; 
//   var count =0.obs;

// }