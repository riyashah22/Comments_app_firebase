import 'dart:convert'; // For jsonDecode
import 'package:comments_app/model/comments.dart';
import 'package:http/http.dart' as http;

class CommentsController {
  Future<List<Comments>> getComments() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));

    if (response.statusCode == 200) {
      // Decode the JSON response
      final List<dynamic> jsonData = json.decode(response.body);

      // Convert to List<Comments>
      return jsonData.map((json) => Comments.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
