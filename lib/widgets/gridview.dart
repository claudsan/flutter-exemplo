
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:livros/models/Book.dart';
import 'package:livros/screens/select_book_screen.dart';

class BookGridView extends StatelessWidget {
  final List<Book> books;
  final BuildContext context;

  BookGridView({Key? key, required this.books, required this.context}) : super(key: key);

  GestureDetector getStructuredGridCell(Book book) {
    return new GestureDetector(
          onTap: (){
            print('Clicado no livro');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectedBookStreen(book: book)));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 19),
            height: 160,
            width: MediaQuery.of(context).size.width - 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Container(
                height: 160,
                width: 128,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(image: NetworkImage(book.volumeInfo!.imageLinks!.thumbnail!),fit: BoxFit.cover)),
              ),
            ],
          ),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      primary: true,
      crossAxisCount: 2,
      childAspectRatio: 1,
      physics: const AlwaysScrollableScrollPhysics(),
      children: List.generate(books.length, (index) {
        return getStructuredGridCell(books[index]);
      }),
    );
  }
}
