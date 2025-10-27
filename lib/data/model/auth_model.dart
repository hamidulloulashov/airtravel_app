class UserRegistrationRequest {
  final String phoneNumber;

  UserRegistrationRequest({required this.phoneNumber});

  Map<String, dynamic> toJson() => {
        'phone_number': phoneNumber,
      };
}


class UserRegistrationResponse {
  final bool? exist; 
  final String? message;

  UserRegistrationResponse({
    this.exist,
    this.message,
  });

  factory UserRegistrationResponse.fromJson(Map<String, dynamic> json) {
    final exist = json['exist'] as bool?;
    final message = json['message'] as String?;
    
    
    return UserRegistrationResponse(
      exist: exist,
      message: message,
    );
  }
}

class VerificationRequest {
  final String phoneNumber;
  final String code;

  VerificationRequest({
    required this.phoneNumber,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
        'phone_number': phoneNumber,
        'code': code,
      };
}

class VerificationResponse {
  final String token;
  final String refreshToken;
  final UserData? user;
  final bool? exist;
  VerificationResponse({
    required this.token,
    this.refreshToken = '',
    this.user,
    this.exist,
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) {
    
    final token = json['access'] ?? json['token'] ?? '';
    
    if (token.isNotEmpty) {
      final tokenPreview = token.length > 20 ? token.substring(0, 20) : token;
    } else {
    }
    
    final refreshToken = json['refresh'] ?? '';
    if (refreshToken.isNotEmpty) {
    }
    
    final exist = json['exist'] as bool?;
    
    final userData = json['user'] != null 
        ? UserData.fromJson(json['user'] as Map<String, dynamic>)
        : null;
        
    if (userData == null) {
    } else {
    }
  
    
    return VerificationResponse(
      token: token,
      refreshToken: refreshToken,
      user: userData,
      exist: exist,
    );
  }
}

class UserData {
  final int? id;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final int? region;

  UserData({
    this.id,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.region,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as int?,
      phoneNumber: json['phone_number'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      profileImage: json['profile_image'] as String?,
      region: json['region'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'phone_number': phoneNumber,
        'first_name': firstName,
        'last_name': lastName,
        'profile_image': profileImage,
        'region': region,
      };

  @override
  String toString() {
    return 'UserData(id: $id, phone: $phoneNumber, firstName: $firstName, lastName: $lastName)';
  }
}