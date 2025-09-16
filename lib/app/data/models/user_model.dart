import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String dob;
  final int age;
  final String husbandName;
  final int pregnancyNumber;
  final int miscarriage;
  final int childbirth;
  final String firstDayOfLastPeriod;
  final String estimatedBirthDate;
  final double weight;
  final double height;
  final double upperArmCircumference;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.dob,
    required this.age,
    required this.husbandName,
    required this.pregnancyNumber,
    required this.miscarriage,
    required this.childbirth,
    required this.firstDayOfLastPeriod,
    required this.estimatedBirthDate,
    required this.weight,
    required this.height,
    required this.upperArmCircumference,
    this.createdAt,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      dob: data['date_of_birth'] ?? '',
      age: data['age'] ?? 0,
      husbandName: data['husbandName'] ?? '',
      pregnancyNumber: data['pregnancy_number'] ?? 0,
      miscarriage: data['miscarriage'] ?? 0,
      childbirth: data['childbirth'] ?? 0,
      firstDayOfLastPeriod: data['firstDayOfLastPeriod'] ?? '',
      estimatedBirthDate: data['estimatedBirthDate'] ?? '',
      weight: data['weight'] ?? 0,
      height: data['height'] ?? 0,
      upperArmCircumference: data['upperArmCircumference'] ?? 0,
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'date_of_birth': dob,
      'age': age,
      'husbandName': husbandName,
      'pregnancy_number': pregnancyNumber,
      'miscarriage': miscarriage,
      'childbirth': childbirth,
      'firstDayOfLastPeriod': firstDayOfLastPeriod,
      'estimatedBirthDate': estimatedBirthDate,
      'weight': weight,
      'height': height,
      'upperArmCircumference': upperArmCircumference,
      'createdAt': createdAt,
    };
  }
}
