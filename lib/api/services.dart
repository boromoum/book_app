import 'dart:convert';

import 'package:book_app/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class BookRepo {
  Future<List<Book>> getBookList();
}

class BooksServices implements BookRepo {
  static const _baseUrl = 'assignment-be.jaksmok.com';
  static const String _GET_BOOKS = '/api/v1/books';

  static const String username = 'sampleId';
  static const String password = 'Secret';
  String basicAuth =
      'Basic ' + base64.encode(utf8.encode('$username:$password'));

  @override
  Future<List<Book>> getBookList() async {
    Uri uri = Uri.http(_baseUrl, _GET_BOOKS);
    Response response = await http
        .get(uri, headers: <String, String>{'authorization': basicAuth});
    print("${response.body}");
    List<Book> books = bookFromJson(response.body);
    print("book: ${books.length}");
    return books;
  }
}
