import 'package:gallery_app/data/models/user_model.dart';

import 'meta_data.dart';

class UserResponse {
  late MetaData metaData;
  late User data;

  UserResponse();

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    UserResponse userResponse = UserResponse();

    userResponse.metaData = MetaData.fromJson(json['meta_data']);

    if (json['data'] != null) userResponse.data = User.fromJson(json['data']);

    return userResponse;
  }
}
