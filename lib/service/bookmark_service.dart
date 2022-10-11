
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:livros/models/google_books.dart';

import 'package:livros/models/Book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkService{

  static const KEY = "bookmarks";
  final SharedPreferences prefs;

  BookMarkService(this.prefs);

  Future<GoogleBooks?> getBookmarks() async {
    String? books = prefs.getString(KEY);
    try {
      if (books != null) {
        return GoogleBooks.fromJson(jsonDecode(books));
      }
    }catch(e){
      print(e);
    }
    return GoogleBooks(items: [], totalItems: 0);
  }

  Future<void> updateBookmark(Book book, BuildContext context) async {
    var books = await getBookmarks();
    var exists = books?.items.where((b) => b.id == book.id);

    var message = "";
    if(exists!.isNotEmpty){
      books!.items.removeWhere((item) => item.id == book.id);
      message = "Removido dos favoritos!";
    }else{
      books?.items.add(book);
      message = "Adicionado nos favoritos!";
    }
    await prefs.setString(KEY, jsonEncode(books));

    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'Fechar', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );

  }

}