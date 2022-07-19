import 'dart:convert';
import 'package:book_app/bloc/books1/states.dart';
import 'package:book_app/bloc/books1/events.dart';
import 'package:book_app/models/book.dart';

import 'package:http/http.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

class BooksBloc1 extends Bloc<BooksEvent, BooksState> {
  final http.Client? httpClient;
  int total = 100;
  int page = 0;

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  BooksBloc1({this.httpClient}) : super(const BooksInitial()) {
    on<BooksFetched>(
      (event, emit) async {
        try {
          if (state is BooksInitial) {
            final books = await _fetchBooks();
            return emit(BooksFetchSuccess(books, false));
          }
          page += 1;
          if (page < total / 20) {
            final books = await _fetchBooks(page);
            books.isEmpty
                ? emit(BooksFetchSuccess(books, true))
                : emit(BooksFetchSuccess(
                    List.of(state.books)..addAll(books), false));
          }
        } catch (e) {
          emit(BooksFetchFailure(
            state.books,
            state.hasReachedMaximum,
            e,
          ));
        }
      },
      transformer: throttleDroppable(const Duration(microseconds: 500)),
    );
  }

  Future<List<Book>> _fetchBooks([int startIndex = 0]) async {
    const _baseUrl = 'assignment-be.jaksmok.com';
    const String _GET_BOOKS = '/api/v1/books';
    const String username = 'sampleId';
    const String password = 'Secret';
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    Uri uri = Uri.http(
      _baseUrl,
      _GET_BOOKS,
      <String, String>{'page': '$startIndex', 'size': '20'},
    );
    Response response = await http
        .get(uri, headers: <String, String>{'authorization': basicAuth});
    List<Book> books = bookFromJson(response.body);
    return books;
  }
}
