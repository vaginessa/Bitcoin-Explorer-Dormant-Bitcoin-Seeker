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

  int currentTabIndex = 0;
  TextEditingController inputController = TextEditingController();
  bool onFirst = true;
  bool isSearching = false;

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
            child: TextFormField(
              controller: inputController,
              style: const TextStyle(color:Colors.white),
              decoration: InputDecoration(
                fillColor: inputColor,
                filled: true,
                suffixIcon: const Icon(Icons.search, color:Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 2.0,
                  ),
                ),
                hintText: "Search",
                hintStyle:const TextStyle(color: Colors.grey)
              ),
            ),
          ),
          bottom: TabBar(
            tabs: const [
              TabButton(title: "ADDRESS",),
              TabButton(title: "PRIVATE KEY",),
              TabButton(title: "SEED PHRASE",),
            ],
            onTap: onChangeTab,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left:lateralContentMargins.left, right:lateralContentMargins.right,top:5),
          child: TabBarView(
            children: [
              //TAB ADDRESS
              if(WalletGeneratorState.searchResultByAddress != null)
                Column(
                  children : [
                    WalletGeneratorState.searchResultByAddress!
                  ]
                )
              else
                Center(
                  child: Text(onFirst ? "Empty" : "Invalid address", style: const TextStyle(color: Colors.white, fontSize: 22.5),)
                ),
              // TAB PRIVATE KEY
              if(WalletGeneratorState.searchResultByPrivateKey != null)
                Column(
                  children : [
                    WalletGeneratorState.searchResultByPrivateKey!
                  ]
                )
              else
                Center(
                  child: Text(onFirst ? "Empty" : "Invalid private key", style: const TextStyle(color: Colors.white, fontSize: 22.5),)
                ),
              // TAB SEED PHRASE
              if(WalletGeneratorState.searchResultBySeedPhrase != null)
                Column(
                  children : [
                    WalletGeneratorState.searchResultBySeedPhrase!
                  ]
                )
              else
                const Center(
                  child: Text("Invalid seed phrase", style: TextStyle(color: Colors.white, fontSize: 22.5),)
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          backgroundColor:Colors.blue,
          onPressed: () { 
            if(isSearching == false){
              onSearch(inputController.text);
            }
          },
        ),
      )
    );
  }

  Isolate? searchThread;
  void onSearch(String search) async{  
    isSearching = true;  
    BitcoinLib bitcoin = BitcoinLib();

    final receivePort = ReceivePort();

    Map<String, Object> params = {};
    params["sendPort"] = receivePort.sendPort;

    if(currentTabIndex == 0){
      params["address"] = search;

      try{
        searchThread = await Isolate.spawn(bitcoin.searchByAddress,params);
      }
      on Exception{
        isSearching = false;
      }

      receivePort.listen((response) {
        isSearching = false;
        if(response != null){
          WalletGeneratorState.searchResultByAddress = response;
        }
        else{
          WalletGeneratorState.searchResultByAddress = null;
        }
        setState(() {});
      });
    }
    else if(currentTabIndex == 1){
      params["privateKey"] = search;
      try{
        searchThread = await Isolate.spawn(bitcoin.searchByPrivateKey,params);
      }
      on Exception{
        isSearching = false;
      }

      receivePort.listen((response) {
        isSearching = false;
        if(response != null){
          WalletGeneratorState.searchResultByPrivateKey = response;
        }
        else{
          WalletGeneratorState.searchResultByPrivateKey = null;
        }
        setState((){});
      });
    }
    else if(currentTabIndex == 2){
      params["seedPhrase"] = search;
      try{
        searchThread = await Isolate.spawn(bitcoin.searchBySeedPhrase,params);
      }
      on Exception{
        isSearching = false;
      }

      receivePort.listen((response) {
        isSearching = false;
        if(response != null){
          WalletGeneratorState.searchResultBySeedPhrase = response;
        }
        else{
          WalletGeneratorState.searchResultBySeedPhrase = null;
        }
        setState((){});
      });
    }

    if(onFirst){
      setState(() {
        onFirst = false;
      });
    }
  }

  void onChangeTab(int index){
    currentTabIndex = index;
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
    return SizedBox(
      height: 45,
      child: Center(
        child: Text(title)
      )
    );
  }
}