class Post {
  final int albumId;
  final int id;
  final String url;
  final String thumbnailUrl;
  final String title;

  Post({this.albumId, this.id, this.url, this.thumbnailUrl, this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        albumId: json['albumId'],
        id: json['id'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl'],
        title:  json['title']
    );
  }
  @override
  String toString() {
    return 'Post{albumId: $albumId, id: $id, url: $url, thumbnailUrl: $thumbnailUrl, title: $title}';
  }
}



