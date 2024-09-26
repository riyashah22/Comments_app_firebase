import 'package:comments_app/provider/comments_provider.dart';
import 'package:comments_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CommentsProvider>(context, listen: false).getAllComments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final commentsProvider = Provider.of<CommentsProvider>(context);
    final comments =
        commentsProvider.comments; // Assuming a list is stored here

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: ThemeClass.lightPrimaryColor,
        title: const Text(
          "Comments",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: comments.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                // print(comment);
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: ThemeClass.lightPrimaryColor,
                      child: Text(
                        comment.name![0]
                            .toUpperCase(), // First letter of the person's name
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Poppins'),
                      ), // Background color of CircleAvatar
                    ),
                    title: Text(
                      "Name: ${comment.name}",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic,
                          fontWeight:
                              FontWeight.bold), // Italicized label for Name
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email: ${comment.email}",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight
                                  .bold), // Italicized label for Email
                        ),
                        const SizedBox(height: 5),
                        Text(
                          comment.body!,
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
