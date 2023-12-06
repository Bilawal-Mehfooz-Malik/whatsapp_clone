class UserModel {
  UserModel({
    required this.uid,
    required this.name,
    required this.isOnline,
    required this.profilePic,
    required this.phoneNumber,
    required this.groupId,
  });
  final String uid;
  final String name;
  final bool isOnline;
  final String profilePic;
  final String phoneNumber;
  final List<String> groupId;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'groupId': groupId,
      'isOnline': isOnline,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      isOnline: map['isOnline'] ?? false,
      profilePic: map['profilePic'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      groupId: List<String>.from(map['groupId']),
    );
  }
}
