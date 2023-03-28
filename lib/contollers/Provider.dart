import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProviderAuth extends ChangeNotifier{
  // ignore: non_constant_identifier_names
  late String Uid;
  late String email;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool>  createUser(String email, String password) async {

    bool success = false;

    try{
        UserCredential userCredential =await auth.createUserWithEmailAndPassword(email: email, password:password);

          Uid=userCredential.user!.uid;
//email = userCredential.user.email;

          return success = true;
        }catch(e){
            print(e.toString);

        }
        return success;

    
  }

  Future<bool>  LoginProv(String email, String password) async {

    bool success = false;

    try{
        UserCredential userCredential =await  auth.signInWithEmailAndPassword(email: email, password:password);

        if(userCredential!=null){
            Uid=userCredential.user!.uid;
//email = userCredential.user.email;

            return success = true;
        }
        }catch(e){
            print(e.toString);

        }
        return success;

    
  }

  void logOut() {
      auth.signOut();
  }
}