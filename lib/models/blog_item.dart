class Blog {
  String? title;
  String? date;
  String? link;
  String? author;
  String? thumbnail;
  String? description;
  String? content;

  Blog(
      {this.title,
      this.date,
      this.link,
      this.author,
      this.thumbnail,
      this.description,
      this.content});

  factory Blog.fromJSON(Map<String, dynamic> json) {
    return Blog(
        title: json["title"],
        date: json['pubDate'],
        link: json['link'],
        author: json['author'],
        thumbnail: json['thumbnail'],
        description: json['description'],
        content: json['content']);
  }
}
