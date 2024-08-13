import 'dart:convert';

Postmodel welcomeFromMap(String str) => Postmodel.fromMap(json.decode(str));

String welcomeToMap(Postmodel data) => json.encode(data.toMap());

class Postmodel {
  List<Post> posts;
  int total;
  int skip;
  int limit;

  Postmodel({
    required this.posts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory Postmodel.fromMap(Map<String, dynamic> json) => Postmodel(
        posts: List<Post>.from(json["posts"].map((x) => Post.fromMap(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toMap() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toMap())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Post {
  int id;
  String title;
  String body;
  List<String> tags;
  Reactions reactions;
  int views;
  int userId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.reactions,
    required this.views,
    required this.userId,
  });

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        reactions: Reactions.fromMap(json["reactions"]),
        views: json["views"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "body": body,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "reactions": reactions.toMap(),
        "views": views,
        "userId": userId,
      };
}

class Reactions {
  int likes;
  int dislikes;

  Reactions({
    required this.likes,
    required this.dislikes,
  });

  factory Reactions.fromMap(Map<String, dynamic> json) => Reactions(
        likes: json["likes"],
        dislikes: json["dislikes"],
      );

  Map<String, dynamic> toMap() => {
        "likes": likes,
        "dislikes": dislikes,
      };
}
