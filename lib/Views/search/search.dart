import 'package:bitbox/bitbox.dart';
import 'package:flutter/material.dart';

import '../../global.dart';

class Search extends StatefulWidget {
  const Search({ Key? key }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor:appBarBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 110,
          backgroundColor: appBarBackgroundColor,
          title : Container(
            margin: const EdgeInsets.only(top:30),
            child: TextFormField(
              initialValue: "",
              style: const TextStyle(color:Colors.white),
              decoration: InputDecoration(
                fillColor: inputColor,
                filled: true,
                suffixIcon:const Icon(Icons.search),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Search",
                hintStyle:const TextStyle(color: Colors.grey)
              ),
            ),
          ),
          bottom: const TabBar(
            tabs: [
              TabButton(title: "ADDRESS",),
              TabButton(title: "PRIVATE KEY",),
              TabButton(title: "SEED PHRASE",),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      )
    );
  }
}

class TabButton extends StatelessWidget {
  const TabButton({
    Key? key,
    required this.title
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Center(
        child: Text(title)
      )
    );
  }
}