import 'package:book_app/models/book.dart';
import 'package:flutter/material.dart';

class BookItemCard extends StatelessWidget {
  const BookItemCard({Key? key, this.book, this.onPressed}) : super(key: key);
  final Book? book;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onPressed,
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                book!.imageUrl!,
                width: 100,
                height: 130,
                fit: BoxFit.contain,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 10.0,
                  bottom: 10,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        book!.title!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Author: " + book!.author!,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Year: " + book!.year!,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Page: " + book!.pages!.toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
