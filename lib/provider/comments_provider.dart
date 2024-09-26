import 'package:comments_app/controller/all_comments.dart';
import 'package:comments_app/model/comments.dart';
import 'package:flutter/material.dart';

class CommentsProvider extends ChangeNotifier {
  final CommentsController _commentsController = CommentsController();
  bool isLoading = false;
  List<Comments> comments = [];

  List<Comments> get comment => comments;

  Future<void> getAllComments() async {
    isLoading = true;
    notifyListeners();

    try {
      comments = await _commentsController.getComments();
    } catch (e) {
      print("Error fetching comments: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
