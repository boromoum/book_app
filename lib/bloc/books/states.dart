import 'package:book_app/models/book.dart';
import 'package:equatable/equatable.dart';

abstract class BooksState extends Equatable {
  @override
  List<Object> get props => [];
}

class BooksInitState extends BooksState {}

class BooksLoading extends BooksState {}

class BooksLoaded extends BooksState {
  final List<Book>? books;
  BooksLoaded({this.books});
}

class BooksListError extends BooksState {
  final error;
  BooksListError({this.error});
}
