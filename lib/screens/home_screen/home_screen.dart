import 'package:book_app/bloc/books/bloc.dart';
import 'package:book_app/bloc/books/events.dart';
import 'package:book_app/bloc/books1/bloc.dart';
import 'package:book_app/bloc/books1/events.dart';
import 'package:book_app/screens/home_screen/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _loadBooks();
    _scrollController.addListener(_onScroll);
    _loadBooks1();
  }

  void _onScroll() {
    if (isScrollAtBottom()) {
      context.read<BooksBloc1>().add(BooksFetched());
    }
  }

  bool isScrollAtBottom() {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll * .9;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  _loadBooks() async {
    context.read<BooksBloc>().add(BookEvents.fetchBooks);
  }

  _loadBooks1() {
    context.read<BooksBloc1>().add(BooksFetched());
  }

  @override
  Widget build(BuildContext context) {
    return HomeUI(loadBooks: _loadBooks, scrollController: _scrollController);
  }
}
