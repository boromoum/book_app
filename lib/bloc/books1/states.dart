import 'package:book_app/models/book.dart';

enum Bookstatus { initial, loading, success, failure }

abstract class BooksState {
  final Bookstatus status;
  final List<Book> books;
  final bool hasReachedMaximum;
  const BooksState({
    this.status = Bookstatus.initial,
    this.books = const <Book>[],
    required this.hasReachedMaximum,
  });

  List<Object> get props => [books, hasReachedMaximum];
}

class BooksInitial extends BooksState {
  const BooksInitial() : super(hasReachedMaximum: false);
}

class BooksFetchSuccess extends BooksState {
  const BooksFetchSuccess(
    List<Book> books,
    bool hasReachedMaximum,
  ) : super(
          books: books,
          hasReachedMaximum: hasReachedMaximum,
        );
}

class BooksFetchFailure extends BooksState {
  final dynamic exception;

  const BooksFetchFailure(
    List<Book> books,
    bool hasReachedMaximum,
    this.exception,
  ) : super(
          books: books,
          hasReachedMaximum: hasReachedMaximum,
        );

  @override
  List<Object> get props => [exception.toString()];
}

class BooksFetching extends BooksState {
  final bool isInitial;
  const BooksFetching(
    List<Book> books,
    this.isInitial,
  ) : super(
          hasReachedMaximum: false,
          books: books,
        );
}
