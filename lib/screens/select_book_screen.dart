import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livros/constants/color_constant.dart';
import 'package:livros/models/Book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../service/bookmark_service.dart';

class SelectedBookStreen extends StatefulWidget {
  final Book book;
  const SelectedBookStreen({Key? key, required this.book}) : super(key: key);

  @override
  State<SelectedBookStreen> createState() => _SelectedBookStreenState(this.book);
}

class _SelectedBookStreenState extends State<SelectedBookStreen> {
  final Book book;
  _SelectedBookStreenState(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: book.saleInfo?.buyLink != null ? MaterialButton(
          onPressed: () {
            launchUrl(Uri.parse(book.saleInfo!.buyLink!),mode: LaunchMode.externalApplication);
          },
          child: Text(
            "Comprar",
            style: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: kWhiteColor,
            ),
          ),
          color: kMainColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ): Text("Compra não disponível", style: GoogleFonts.openSans(fontSize: 14, color: kRedColor, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: kMainColor,
                expandedHeight: MediaQuery.of(context).size.height*0.5,
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  //color: Color()
                  child: Stack(
                    children: [
                      Positioned(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MyApp()),
                            );
                          },
                          child: Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: kWhiteColor
                          ),
                          child: SvgPicture.asset("assets/icons/icon_back_arrow.svg"),
                        )),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 62),
                          width: 172,
                          height: 225,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: new NetworkImage(book.volumeInfo!.imageLinks!.thumbnail!)),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Positioned(
                          child: GestureDetector(
                            onTap: () async {
                              var service = BookMarkService(await SharedPreferences.getInstance());
                              service.updateBookmark(this.book, context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10, right: 10),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kWhiteColor
                              ),
                              child: SvgPicture.asset("assets/icons/icon_bookmark_colored.svg"))
                        )
                          )
                        ),
                      ]),
                    ),
                  ),
              SliverList(delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.only(top: 7, left: 25) ,
                    child: Text(
                      book.volumeInfo!.title,
                      style: GoogleFonts.openSans(fontSize: 27, color: kBlackColor, fontWeight: FontWeight.w700)
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7, left: 25) ,
                    child: Text(
                        book.volumeInfo!.authors!.join(", ") ?? "",
                        style: GoogleFonts.openSans(fontSize: 14, color: kGreyColor, fontWeight: FontWeight.w400)
                    ),
                  ),
                  book.saleInfo!.listPrice != null ? Padding(
                    padding: EdgeInsets.only(top: 7, left: 25),
                    child: Row(
                      children: [
                        Text('R\$', style: GoogleFonts.openSans(fontSize: 14, color: kMainColor, fontWeight: FontWeight.w400)),
                        Text("${book.saleInfo?.listPrice?.amount?.toString() ?? " -.--"}", style: GoogleFonts.openSans(fontSize: 32, color: kMainColor, fontWeight: FontWeight.w400)),
                      ],
                    )
                  ) : Text(""),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    child: Text(book.volumeInfo!.description,
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: kGreyColor,
                      letterSpacing: 1.5,
                      height: 2
                    ),)
                  ),
              ])
            ),
        ]),
      ),
    ),
    );
  }
}
