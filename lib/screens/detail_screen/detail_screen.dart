import 'package:book_app/models/book.dart';
import 'package:book_app/screens/detail_screen/detail_ui.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.book}) : super(key: key);
  final Book? book;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DetailUI(
      book: widget.book,
    );
  }
}
