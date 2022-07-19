import 'package:book_app/bloc/books1/bloc.dart';
import 'package:book_app/bloc/books1/states.dart' as booksState1;
import 'package:book_app/bloc/books1/states.dart';
import 'package:book_app/screens/detail_screen/detail_screen.dart';
import 'package:book_app/widgets/book_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key, this.loadBooks, this.scrollController})
      : super(key: key);
  final VoidCallback? loadBooks;
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.7),
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              color: Colors.white,
            ),
          ),
          BlocBuilder<BooksBloc1, booksState1.BooksState>(
            builder: (context, state) {
              if (state is BooksInitial ||
                  (state is BooksFetching && state.isInitial)) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (state is BooksFetchSuccess ||
                  (state is BooksFetching && !state.isInitial)) {
                return ListView.separated(
                  controller: scrollController,
                  itemBuilder: (context, i) {
                    if (i >= state.books.length) {
                      return state.hasReachedMaximum
                          ? const SizedBox()
                          : const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            );
                    } else {
                      final book = state.books[i];
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
                    }
                  },
                  separatorBuilder: (_, i) => const Divider(),
                  itemCount: state.books.length + 1,
                );
              } else if (state is BooksFetchFailure) {
                return ErrorWidget(exception: state.exception);
              } else {
                return const SizedBox();
              }
            },
          )

          // CustomScrollView(
          //   physics: const AlwaysScrollableScrollPhysics(
          //       parent: ClampingScrollPhysics(
          //           parent: RangeMaintainingScrollPhysics())),
          //   controller: scrollController,
          //   slivers: [
          //     SliverAppBar(
          //       centerTitle: true,
          //       backgroundColor: Colors.white.withOpacity(0.7),
          //       pinned: true,
          //       expandedHeight: height * 0.15,
          //       // collapsedHeight: height * 0.075,
          //       flexibleSpace: LayoutBuilder(
          //         builder: (context, constraints) {
          //           double appBarHeight = constraints.biggest.height;
          //           bool isExpanded = appBarHeight > height * 0.2;
          //           return FlexibleSpaceBar(
          //             centerTitle: true,
          //             titlePadding: EdgeInsets.zero,
          //             title: SizedBox(
          //               height: height * 0.15,
          //               child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Column(
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       mainAxisAlignment: isExpanded
          //                           ? MainAxisAlignment.center
          //                           : MainAxisAlignment.end,
          //                       children: <Widget>[
          //                         Container(
          //                           padding: EdgeInsets.all(20),
          //                           child: Text(
          //                             "Home",
          //                             style: TextStyle(color: Colors.black),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ]),
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //     BlocBuilder<BooksBloc1, booksState1.BooksState>(
          //       builder: (context, state) {
          //         if (state is BooksInitial ||
          //             (state is BooksFetching && state.isInitial)) {
          //           return SliverToBoxAdapter(
          //             child: const Center(
          //                 child: CircularProgressIndicator.adaptive()),
          //           );
          //         } else if (state is BooksFetchSuccess ||
          //             (state is BooksFetching && !state.isInitial)) {
          //           List<Book>? books = state.books;
          //           return SliverList(
          //             delegate: SliverChildBuilderDelegate(
          //                 (BuildContext context, int index) {
          //               Book book = books[index];
          //               return BookItemCard(
          //                 book: book,
          //                 onPressed: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => (DetailScreen(
          //                                 book: book,
          //                               ))));
          //                 },
          //               );
          //             }, childCount: books.length),
          //           );
          //         } else if (state is BooksFetchFailure) {
          //           return SliverToBoxAdapter(
          //               child: ErrorWidget(exception: state.exception));
          //         } else {
          //           return SliverToBoxAdapter(child: const SizedBox());
          //         }
          //       },
          //     )
          //     // BlocBuilder<BooksBloc, BooksState>(
          //     //   builder: (BuildContext context, BooksState state) {
          //     //     if (state is BooksListError) {
          //     //       final error = state.error;
          //     //       String message = '${error.message}\nTap to Retry.';
          //     //       return SliverToBoxAdapter(
          //     //         child: Container(
          //     //           height: MediaQuery.of(context).size.height * 0.5,
          //     //           child: ErrorTxt(
          //     //             message: message,
          //     //             onTap: loadBooks,
          //     //           ),
          //     //         ),
          //     //       );
          //     //     }
          //     //     if (state is BooksLoaded) {
          //     //       List<Book>? books = state.books;
          //     //       return SliverList(
          //     //         delegate: SliverChildBuilderDelegate(
          //     //             (BuildContext context, int index) {
          //     //           Book book = books![index];
          //     //           return BookItemCard(
          //     //             book: book,
          //     //             onPressed: () {
          //     //               Navigator.push(
          //     //                   context,
          //     //                   MaterialPageRoute(
          //     //                       builder: (context) => (DetailScreen(
          //     //                             book: book,
          //     //                           ))));
          //     //             },
          //     //           );
          //     //         }, childCount: books!.length),
          //     //       );
          //     //     }
          //     //     return SliverToBoxAdapter(
          //     //         child: Container(
          //     //             height: MediaQuery.of(context).size.height * 0.5,
          //     //             child: Loading()));
          //     //   },
          //     // ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final dynamic exception;
  const ErrorWidget({
    Key? key,
    required this.exception,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Colors.red,
            size: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text(
              exception.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
