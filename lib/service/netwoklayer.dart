import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:livros/models/google_books.dart';

Future<GoogleBooks?> fetchBooks(http.Client client, int start) async {
  final response = await client.get('https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=10&startIndex=${start>0?start*10:start}');
  return compute(parseData, response.body);
}

GoogleBooks parseData(String responseBody) {
  Map<String, dynamic> bookMap = jsonDecode(responseBody);
  var googleBook = GoogleBooks.fromJson(bookMap);
  return googleBook;
}