import 'package:livros/models/Book.dart';

class GoogleBooks {
  String? kind;
  int? totalItems;
  List<Book> items = [];

  GoogleBooks({this.kind, this.totalItems, required this.items});

  GoogleBooks.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    totalItems = json['totalItems'];
    if (json['items'] != null) {
      items = <Book>[];
      json['items'].forEach((v) {
        try {
          items!.add(new Book.fromJson(v));
        }catch(e){
          print(e);
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['totalItems'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
