import 'package:airtravel_app/data/model/region_model.dart';

class UserModel {
  final String? firstName;
  final String? lastName;
  final RegionModel? region;
  final String? phoneNumber;
  final bool? isVerified;
  final double? balance;

  UserModel({
    this.firstName,
    this.lastName,
    this.region,
    this.phoneNumber,
    this.isVerified,
    this.balance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      region: json['region'],
      phoneNumber: json['phone_number'],
      isVerified: json['is_verified'],
      balance: (json['balance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'region': region,
    'phone_number': phoneNumber,
    'is_verified': isVerified,
    'balance': balance,
  };
}
