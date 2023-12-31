import 'dart:convert';

import 'package:http/http.dart';
import 'package:state_management_compared/features/home_page/data/models/post.dart';

class HomePageApiService {
  static Future<List<Post>> getPosts(
      {required int offset}) async {
    final response = await get(Uri.parse(
        'https://api.slingacademy.com/v1/sample-data/users?offset=$offset&limit=10'));
    List<dynamic> users = jsonDecode(response.body)['users'];
    return users.map((user) => Post.fromJson(user)).toList();
  }
}
