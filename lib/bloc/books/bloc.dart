// event, state => new state => update UI.

import 'dart:io';

import 'package:book_app/api/exceptions.dart';
import 'package:book_app/api/services.dart';
import 'package:book_app/bloc/books/events.dart';
import 'package:book_app/bloc/books/states.dart';
import 'package:book_app/models/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksBloc extends Bloc<BookEvents, BooksState> {
  final BookRepo? bookRepo;
  List<Book>? books;

  BooksBloc({
    this.bookRepo,
  }) : super(BooksInitState()) {
    on<BookEvents>(_onGetAllPokemons);
  }

  Future<void> _onGetAllPokemons(
    BookEvents event,
    Emitter<BooksState> emit,
  ) async {
    try {
      emit(BooksLoading());
      final books = await bookRepo?.getBookList();
      emit(BooksLoaded(books: books));
    } on SocketException {
      BooksListError(
        error: NoInternetException('No Internet'),
      );
    } on HttpException {
      BooksListError(
        error: NoServiceFoundException('No Service Found'),
      );
    } on FormatException {
      BooksListError(
        error: InvalidFormatException('Invalid Response format'),
      );
    } catch (e) {
      BooksListError(
        error: UnknownException('Unknown Error'),
      );
    }
  }
}
