import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thriftify_fyp_1/utils/formatters/formatter.dart';

/// Model class representing user data.
class UserModel {
  /// Immutable values
  final String id;
  final String username;
  final String email;

  /// Mutable fields
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;

  /// Constructor
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Computed properties
  String get fullName => '$firstName $lastName';
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Utility methods
  static List<String> nameParts(String fullName) => fullName.split(" ");

  static String generateUsername(String fullName) {
    final parts = fullName.split(" ");
    final first = parts.isNotEmpty ? parts[0].toLowerCase() : '';
    final last = parts.length > 1 ? parts[1].toLowerCase() : '';
    return 'cwt_${first + last}';
  }

  /// Empty user factory
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
      );

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
      };

  /// Create UserModel from Firestore snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) throw Exception('Document data is null');

    return UserModel(
      id: document.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profilePicture: data['profilePicture'] ?? '',
    );
  }
}  
