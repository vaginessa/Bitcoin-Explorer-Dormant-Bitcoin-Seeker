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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          width: double.infinity,
          height:125,
          color: appBarBackgroundColor,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
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
                    )
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}