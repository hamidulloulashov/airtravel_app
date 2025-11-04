import 'package:airtravel_app/data/model/region_model.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final RegionModel region;
  final String phoneNumber;
  final bool isVerified;
  final double balance;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.region,
    required this.phoneNumber,
    required this.isVerified,
    required this.balance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      region: json['region'] is int
          ? RegionModel(id: json['region'], title: '')
          : RegionModel.fromJson(json['region']),
      phoneNumber: json['phone_number'] ?? '',
      isVerified: json['is_verified'] ?? false,
      balance: (json['balance'] ?? 0).toDouble(),
    );
  }
  Map<String, dynamic> toJsonForPatch() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'region': region.id,
    };
  }

}
