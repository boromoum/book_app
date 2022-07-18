import 'package:book_app/models/book.dart';
import 'package:flutter/material.dart';

class DetailUI extends StatelessWidget {
  const DetailUI({Key? key, this.book}) : super(key: key);
  final Book? book;

  @override
  Widget build(BuildContext context) {
    var top = 0.0;
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    leading: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    backgroundColor: Colors.white,
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                          centerTitle: true,
                          background: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.network(
                              book!.imageUrl ?? 'none',
                              fit: BoxFit.contain,
                            ),
                          ));
                    })),
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book!.title!,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Author: " + book!.author!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            )));
  }
}
