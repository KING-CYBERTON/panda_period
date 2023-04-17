
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserData {

  String? id;
  String name;
  String email;
  int periodLength;
  int periodCycle;
  DateTime startDate;
  int reminder;
  

  UserData({
    this.id,
    required this.name,
    required this.email,
    required this.periodLength,
    required this.periodCycle,
    required this.startDate,
    required this.reminder,
    
  });


 

  toJson() {
    return {
      'name': name,
      'email': email,
      'period_length': periodLength,
      'period_cycle': periodCycle,
      'start_date': startDate,
      'reminder': reminder,
    };
  }

  factory UserData.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final json = document.data();
    return UserData(
      
      id: document.id,
      name: json!['name'],
      email: json['email'],
      periodLength: json['period_length'],
      periodCycle: json['period_cycle'],
      startDate: json['start_date'].toDate(),
      reminder: json['reminder'],
    );
  }
}