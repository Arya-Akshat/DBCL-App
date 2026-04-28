class UserProfile {
  const UserProfile({
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    this.emergencyContact = '',
    this.profilePhotoPath,
    this.licenseImagePath,
    this.score = 82,
  });

  final String userId;
  final String name;
  final String phone;
  final String address;
  final String email;
  final String emergencyContact;
  final String? profilePhotoPath;
  final String? licenseImagePath;
  final int score;

  UserProfile copyWith({
    String? userId,
    String? name,
    String? phone,
    String? address,
    String? email,
    String? emergencyContact,
    String? profilePhotoPath,
    bool clearProfilePhoto = false,
    String? licenseImagePath,
    int? score,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      profilePhotoPath: clearProfilePhoto ? null : (profilePhotoPath ?? this.profilePhotoPath),
      licenseImagePath: licenseImagePath ?? this.licenseImagePath,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'name': name,
        'phone': phone,
        'address': address,
        'email': email,
        'emergency_contact': emergencyContact,
        'profile_photo_path': profilePhotoPath,
        'license_image_path': licenseImagePath,
        'score': score,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'] as String? ?? json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
      email: json['email'] as String? ?? '',
      emergencyContact: json['emergency_contact'] as String? ?? '',
      profilePhotoPath: json['profile_photo_path'] as String?,
      licenseImagePath: json['license_image_path'] as String?,
      score: json['score'] as int? ?? 82,
    );
  }
}
