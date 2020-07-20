import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          "DSRDinheiro",
        ),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("imagens/dollar.png"))),
                ),
              ),
            ),
            onTap: () {},
          ),
          GestureDetector(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("imagens/cash.png"))),
                ),
              ),
            ),
            onTap: () {},
          ),
          GestureDetector(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("imagens/grow.png"))),
                ),
              ),
            ),
            onTap: () {},
          ),
          GestureDetector(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("imagens/calendar.png"))),
                ),
              ),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
