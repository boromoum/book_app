import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str)['content'].map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  int? id;
  String? title;
  String? author;
  String? realYears;
  String? year;
  String? country;
  String? language;
  int? pages;
  String? wikipediaLink;
  String? imageUrl;

  Book(
      {this.id,
      this.title,
      this.author,
      this.realYears,
      this.year,
      this.country,
      this.language,
      this.pages,
      this.wikipediaLink,
      this.imageUrl});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    realYears = json['realYears'];
    year = json['year'];
    country = json['country'];
    language = json['language'];
    pages = json['pages'];
    wikipediaLink = json['wikipediaLink'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['realYears'] = this.realYears;
    data['year'] = this.year;
    data['country'] = this.country;
    data['language'] = this.language;
    data['pages'] = this.pages;
    data['wikipediaLink'] = this.wikipediaLink;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
