import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_portfolio/models/bloglist.dart';

class Medium {
  String url =
      "https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/@arnona56";

  Future<BlogList> getAllBlogs() async {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200)
      return BlogList.fromJSON(
        json.decode(response.body),
      );
    throw Exception("API FAILED!");
  }
}
