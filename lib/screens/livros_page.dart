import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:livros/models/Book.dart';
import 'package:livros/screens/select_book_screen.dart';
import 'package:http/http.dart' as http;
import 'package:livros/service/netwoklayer.dart';

class LivrosPage extends StatefulWidget {
  const LivrosPage({Key? key}) : super(key: key);

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage>  with AutomaticKeepAliveClientMixin<LivrosPage> {

  @override
  bool get wantKeepAlive => true;

  List<Book> dataList = [];
  bool isLoading = false;
  int pageCount = 1;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    addItemIntoLisT(0);

    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  GestureDetector getStructuredGridCell(Book book) {
    return new GestureDetector(
      onTap: (){
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

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Color(0xFFFEF9EB),
        ),
        home: Scaffold(
            body: GridView.count(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              physics: const AlwaysScrollableScrollPhysics(),
              children: dataList.map((book) {
                return Container(
                  alignment: Alignment.center,
                  child: getStructuredGridCell(book),
                );
              }).toList(),
            )));
  }

  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isLoading = true;
        if (isLoading) {
          pageCount = pageCount + 1;
          addItemIntoLisT(pageCount);
        }
      });
    }
  }

  Future<void> addItemIntoLisT(var pageCount) async {
    var res = await fetchBooks(new http.Client(), pageCount);
    dataList.addAll(res!.items);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}