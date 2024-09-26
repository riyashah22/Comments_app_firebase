import 'package:comments_app/provider/comments_provider.dart';
import 'package:comments_app/themes.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  bool displayFullEmail = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CommentsProvider>(context, listen: false).getAllComments();
    });
    fetchRemoteConfig();
  }

  Future<void> fetchRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();

    setState(() {
      displayFullEmail = remoteConfig.getBool('display_full_email');
      print('Display full email: $displayFullEmail');
    });
  }

  String formatEmail(String email) {
    if (!displayFullEmail) {
      // Show only the first 3 letters of the email and mask the rest
      final splitEmail = email.split('@');
      if (splitEmail.length == 2 && splitEmail[0].length > 3) {
        String maskedEmail =
            '${splitEmail[0].substring(0, 3)}*****@${splitEmail[1]}';
        return maskedEmail;
      }
    }
    return email; // Return full email if displayFullEmail is true
  }

  @override
  Widget build(BuildContext context) {
    final commentsProvider = Provider.of<CommentsProvider>(context);
    final comments = commentsProvider.comments; // Assuming a list of comments

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
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: ThemeClass.lightPrimaryColor,
                      child: Text(
                        comment.name![0].toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    title: Text(
                      "Name: ${comment.name}",
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email: ${formatEmail(comment.email!)}",
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          comment.body!,
                          style: const TextStyle(fontFamily: 'Poppins'),
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
