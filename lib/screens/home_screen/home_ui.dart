import 'package:book_app/bloc/books/bloc.dart';
import 'package:book_app/bloc/books/states.dart';
import 'package:book_app/models/book.dart';
import 'package:book_app/screens/detail_screen/detail_screen.dart';
import 'package:book_app/widgets/book_item_card.dart';
import 'package:book_app/widgets/error.dart';
import 'package:book_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key, this.loadBooks}) : super(key: key);
  final VoidCallback? loadBooks;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              color: Colors.white,
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                backgroundColor: Colors.white.withOpacity(0.7),
                pinned: true,
                expandedHeight: height * 0.15,
                // collapsedHeight: height * 0.075,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    double appBarHeight = constraints.biggest.height;
                    bool isExpanded = appBarHeight > height * 0.2;
                    return FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: EdgeInsets.zero,
                      title: SizedBox(
                        height: height * 0.15,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: isExpanded
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "Home",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<BooksBloc, BooksState>(
                builder: (BuildContext context, BooksState state) {
                  if (state is BooksListError) {
                    final error = state.error;
                    String message = '${error.message}\nTap to Retry.';
                    return SliverToBoxAdapter(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ErrorTxt(
                          message: message,
                          onTap: loadBooks,
                        ),
                      ),
                    );
                  }
                  if (state is BooksLoaded) {
                    List<Book>? books = state.books;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        Book book = books![index];
                        return BookItemCard(
                          book: book,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (DetailScreen(
                                          book: book,
                                        ))));
                          },
                        );
                      }, childCount: books!.length),
                    );
                  }
                  return SliverToBoxAdapter(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Loading()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
