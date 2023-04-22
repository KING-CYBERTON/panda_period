import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_period/app2/usermodel.dart';
import '../contollers/GetAuth.dart';
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
        title: const Text("User Profile"),
      ),
      body: FutureBuilder<UserData>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!;
            return Column(
              children: [
                const SizedBox(height: 30),
                const CircleAvatar(
                  radius: 120,
                  //backgroundColor: Colors.white70,
                  backgroundImage: AssetImage('panda(1).jpg'),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    " ${userData.name}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    " ${userData.email}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 20),
                      // Text("Name: ${userData.name}", style: TextStyle(fontSize: 20)),
                      // SizedBox(height: 10),
                      // Text("Email: ${userData.email}", style: TextStyle(fontSize: 20)),
                      // SizedBox(height: 10),
                      // Text("Period Length: ${userData.periodLength}", style: TextStyle(fontSize: 20)),
                      // SizedBox(height: 10),
                      // Text("Period Cycle: ${userData.periodCycle}", style: TextStyle(fontSize: 20)),
                      // SizedBox(height: 10),
                      // Text("Start Date: ${userData.startDate.toLocal().toString().split(' ')[0]}", style: TextStyle(fontSize: 20)),
                      // SizedBox(height: 10),
                      // Text("Reminder: ${userData.reminder}", style: TextStyle(fontSize: 20)),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Period Length: ${userData.periodLength}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Period Cycle: ${userData.periodCycle}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Start Date: ${userData.startDate.toLocal().toString().split(' ')[0]}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 90),
                ElevatedButton(
                  onPressed: () {
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
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
