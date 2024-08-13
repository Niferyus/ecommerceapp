import 'package:blogcom/models/postmodel.dart';
import 'package:blogcom/service/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  PostService service = PostService();
  List<Post> posts = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadposts();
  }

  Future<void> loadposts() async {
    Postmodel? postModel = await service.fetchPosts();
    setState(() {
      if (postModel != null) {
        posts = postModel.posts;
        isLoaded = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[300],
        elevation: 6,
      ),
      body: isLoaded
          ? ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                var post = posts[index];
                return Card(
                  margin: EdgeInsets.all(12),
                  shadowColor: Colors.grey[300],
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          child: Text(
                            post.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          post.body,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.black87,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            reactionscontainer(post.reactions.likes,
                                CupertinoIcons.hand_thumbsup),
                            reactionscontainer(post.reactions.dislikes,
                                CupertinoIcons.hand_thumbsdown),
                            reactionscontainer(
                                post.views, CupertinoIcons.eye_fill),
                          ],
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Wrap(
                            spacing: 6.0,
                            children: List.generate(
                              post.tags.length,
                              (index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.blue, Colors.cyan],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    post.tags[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget reactionscontainer(int number, IconData? icon) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "$number",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
