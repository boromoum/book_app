import 'package:book_app/bloc/books/bloc.dart';
import 'package:book_app/bloc/books/events.dart';
import 'package:book_app/screens/home_screen/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  _loadBooks() async {
    context.read<BooksBloc>().add(BookEvents.fetchBooks);
  }

  @override
  Widget build(BuildContext context) {
    return HomeUI(
      loadBooks: _loadBooks,
    );
  }
}
