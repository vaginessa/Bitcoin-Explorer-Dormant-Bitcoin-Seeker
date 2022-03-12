import 'dart:isolate';

import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/wallet_generator_state.dart';
import 'package:flutter/material.dart';

import '../../Bitcoin/bitcoinlib.dart';
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
              onChanged: onSearch,
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
        body: Container(
          margin: EdgeInsets.only(left:lateralContentMargins.left, right:lateralContentMargins.right,top:5),
          child: TabBarView(
            children: [
              if(WalletGeneratorState.searchResultByAddress != null)
                Column(
                  children : [
                    WalletGeneratorState.searchResultByAddress!
                  ]
                )
              else
                const Icon(Icons.car_rental),
              const Icon(Icons.directions_transit),
              const Icon(Icons.directions_bike),
            ],
          ),
        ),
      )
    );
  }

  Isolate? randomBrainWalletsThread;
  void onSearch(String search) async{
    BitcoinLib bitcoin = BitcoinLib();

    final receivePort = ReceivePort();

    Map<String, Object> params = {};
    params["address"] = search;
    params["sendPort"] = receivePort.sendPort;

    randomBrainWalletsThread = await Isolate.spawn(bitcoin.searchByAddress,params);
    receivePort.listen((response) {
      WalletGeneratorState.searchResultByAddress = response;
      setState(() {});
    });
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