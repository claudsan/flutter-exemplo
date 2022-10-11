import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livros/constants/color_constant.dart';
import 'package:livros/screens/select_book_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(left: 25, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Seja bem vindo!',
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kGreyColor
                    ),
                ),
                Text('Descubra novos livros',
                  style: GoogleFonts.openSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: kBlackColor
                  ),
                )
              ]
            )
            ),
            Container(
              height: 39,
              margin: const EdgeInsets.only(left: 25, right: 25, top: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kLightGreyColor,
              ),
              child: Stack(
                children: [
                  TextField(
                    maxLengthEnforced: true,
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      color: kBlackColor,
                      fontWeight: FontWeight.w600
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 19,right: 50, bottom: 8),
                      border: InputBorder.none,
                      hintText: 'Pesquisar livros...',
                      hintStyle: GoogleFonts.openSans(
                        fontSize: 12,
                        color: kGreyColor,
                        fontWeight: FontWeight.w600
                      )
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: SvgPicture.asset('assets/svg/background_search.svg',)
                  ),
                  Positioned(
                    top: 8,
                    right: 9,
                    child: SvgPicture.asset('assets/icons/icon_search_white.svg'),
                  )
                ],
              ),
            ),
            Container(
              height: 25,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(left: 25),
              child: const DefaultTabController(
                length: 3,
                child: TabBar(
                  labelPadding: EdgeInsets.only( right: 25),
                    isScrollable: true,
                    labelColor: kBlackColor,
                    labelStyle:  TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w700),
                    unselectedLabelStyle:TextStyle(
                        fontSize: 19.0,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: kBlackColor, width: 3.0),
                      insets: EdgeInsets.fromLTRB(0.0, 0.0,60.0, -3.0),
                    ),
                    //indicator: RoundedRectangleTabIndicator(color: kBlackColor, weight: 2, width: 10),
                    tabs: <Widget>[
                  Tab(
                    text: 'Novidades',
                  ),
                  Tab(
                    text: 'Best Seller',
                  ),
                  Tab(
                    text: 'Favoritos',
                  )
                ])
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 21),
              height: 210,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 25, right: 6),
                  itemCount: 1,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                Container(
                  margin: const EdgeInsets.only(right: 19),
                height: 210,
                width: 153,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kMainColor,
                  image: const DecorationImage(image: AssetImage('assets/images/img_newbook1.png'))
                ),
              )
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 25, top: 25),
                child: Text('Mais populares',
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kBlackColor
                    ),
                )
            ),
            ListView.builder(
              padding: EdgeInsets.only(top: 25, right: 25, left: 25),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
                itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  print('Clicado no livro');
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => SelectedBookStreen()));
                },
                child: Container(
                margin: EdgeInsets.only(bottom: 19),
                height: 90,
                width: MediaQuery.of(context).size.width - 50,
                color: kBackgroundColor,
                child: Row(
                  children: [
                    Container(
                      height: 90,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(image: AssetImage("assets/images/img_popular_book1.png"))
                      ),
                      //color: kMainColor
                    ),
                    SizedBox(width: 21),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Titulo 1", style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w600, color: kBlackColor),),
                        SizedBox(height: 5),
                        Text("Autor 1", style: GoogleFonts.openSans(fontSize: 10, fontWeight: FontWeight.w600, color: kGreyColor),),
                        SizedBox(height: 5),
                        Text("10.00", style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600, color: kBlackColor),),
                      ],
                    )
                  ],
                ),
              ),
              );
            }),
            Container(
              child:             GridView.count(
                crossAxisCount: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
