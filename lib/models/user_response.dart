import 'package:news_application/models/models.dart';

class UserResponse {
  final String? status;
  final String? message;
  final int? totalResults;
  final User? user;
  
  UserResponse({
    this.status,
    this.message,
    this.totalResults,
    this.user,
  });
}
