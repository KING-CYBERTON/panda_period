import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_period/app2/usermodel.dart';
import '../contollers/fireget.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<UserData> _userDataFuture;
  final repo = Get.put(FireRepo());

  final email = FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    super.initState();
    _userDataFuture = FireRepo.instance.getUserData(email.toString());
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: FutureBuilder<UserData>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Name: ${userData.name}", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text("Email: ${userData.email}", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text("Period Length: ${userData.periodLength}", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text("Period Cycle: ${userData.periodCycle}", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text("Start Date: ${userData.startDate.toLocal().toString().split(' ')[0]}", style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text("Reminder: ${userData.reminder}", style: TextStyle(fontSize: 20)),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
