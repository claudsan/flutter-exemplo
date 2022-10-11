import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livros/models/google_books.dart';
import 'package:livros/service/bookmark_service.dart';
import 'package:livros/widgets/gridview.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LivrosBookmark extends StatefulWidget {
  const LivrosBookmark({Key? key}) : super(key: key);

  @override
  State<LivrosBookmark> createState() => _LivrosBookmarkState();
}

class _LivrosBookmarkState extends State<LivrosBookmark> with AutomaticKeepAliveClientMixin<LivrosBookmark> {
  _LivrosBookmarkState();

  Future<GoogleBooks?> getBookMarks() async {
    var res = await new BookMarkService(await SharedPreferences.getInstance())
        .getBookmarks();

    return res;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      body: new FutureBuilder<GoogleBooks?>(
        future: getBookMarks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          if (snapshot.hasData) {
            var books = snapshot.data;
            if (books?.items != null) {
              return new BookGridView(books: books!.items!, context: context);
            }
          }
          print(snapshot.error.toString());
          return new Center(child: new CircularProgressIndicator());
        },
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
