import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_period/app2/usermodel.dart';

import '../contollers/fireget.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final repo = Get.put(FireRepo());
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: Center(
        child: FutureBuilder<List<UserData>>(
          future: FireRepo.instance.allUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userList = snapshot.data!;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    onTap: () {
                      // TODO: navigate to user detail screen
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
