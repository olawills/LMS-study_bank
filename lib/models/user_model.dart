// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String userUid;
  final String email;
  final String displayName;
  final String photoUrl;
  UserModel({
    required this.userUid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
  });

  UserModel copyWith({
    String? userUid,
    String? email,
    String? displayName,
    String? photoUrl,
  }) {
    return UserModel(
      userUid: userUid ?? this.userUid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userUid': userUid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userUid: map['userUid'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userUid: $userUid, email: $email, displayName: $displayName, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userUid == userUid &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return userUid.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoUrl.hashCode;
  }
}
