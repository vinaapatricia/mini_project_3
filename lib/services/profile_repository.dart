import 'package:http/http.dart';
import 'package:mini_project_3/model/profile_model.dart';
import 'dart:convert';

class ProfileRepository {
  String baseUrl = 'https://fakestoreapi.com/users/1';

  Future<Profile> getProfile() async {
    Response response = await get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return Profile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
