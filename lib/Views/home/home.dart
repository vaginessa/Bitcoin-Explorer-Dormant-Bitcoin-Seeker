import 'dart:async';
import 'dart:isolate';
import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/bitcoinlib.dart';
import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/wallet_generator_state.dart';
import 'package:dormant_bitcoin_seeker_flutter/Shared/card.dart';
import 'package:dormant_bitcoin_seeker_flutter/Stats/wallet_stats.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/home/home_pages/brainwallet_generator.dart';
import 'package:dormant_bitcoin_seeker_flutter/Views/home/home_pages/random_wallet_generator.dart';
import 'package:dormant_bitcoin_seeker_flutter/global.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> content = [
    RandomWalletGenerator(
      wallets: WalletGeneratorState.wallets,
    ),
    BrainwalletGenerator(wallets: WalletGeneratorState.brainWallets)
  ];

  int selectedContent = 0;
  Random rd = Random();
  Timer? intervalCheck;

  @override
  void initState() {
    super.initState();

    intervalCheck = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (WalletStats.boostsCheck()) {
        restartThreads();
        setState(() {});
      }
    });
  }

  @override
  @mustCallSuper
  @protected
  void dispose() {
    intervalCheck?.cancel();
    if (randomBrainWalletsThread != null) {
      randomBrainWalletsThread?.kill();
    }

    if (randomWalletsThread != null) {
      randomWalletsThread?.kill();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    content = [
      RandomWalletGenerator(
        wallets: WalletGeneratorState.wallets.reversed.toList(),
      ),
      BrainwalletGenerator(
          wallets: WalletGeneratorState.brainWallets.reversed.toList())
    ];

    WalletStats.getData();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        width: double.infinity,
        height: double.infinity,
        child: Column(children: [
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: lateralContentMargins.right,
                  ),
                  GestureDetector(
                    child: PreviewCard(
                        icon: const Icon(Icons.account_balance_wallet),
                        title: "Random wallets",
                        subtitle: "Standard Bitcoin wallet",
                        isSelected: selectedContent == 0,
                        color: Colors.blue),
                    onTap: () {
                      if (isPlaying) {
                        togglePlay();
                      }
                      setState(() {
                        selectedContent = 0;
                      });
                    },
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    child: PreviewCard(
                        icon: const Icon(Icons.text_snippet),
                        title: "12 Phrases",
                        subtitle: "Brainwallet",
                        isSelected: selectedContent == 1,
                        color: Colors.blue),
                    onTap: () {
                      if (isPlaying) {
                        togglePlay();
                      }
                      setState(() {
                        selectedContent = 1;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: lateralContentMargins.left,
                right: lateralContentMargins.right,
                top: 15,
                bottom: 15),
            child: Row(
              children: [
                Text(
                  selectedContent == 0
                      ? "Random wallet generator"
                      : selectedContent == 1
                          ? "Brainwallet generator"
                          : "Richest addresses",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(
                    left: lateralContentMargins.left,
                    right: lateralContentMargins.right,
                    top: 5),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [content[selectedContent]],
                    ),
                  ),
                )),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        backgroundColor: isPlaying ? Colors.red : Colors.green,
        onPressed: () {
          togglePlay();
        },
      ),
    );
  }

  bool isPlaying = false;
  Isolate? randomWalletsThread;
  bool onRandomWalletsThread = false;
  Isolate? randomBrainWalletsThread;
  bool onRandomBrainWalletsThread = false;

  Future<void> togglePlay() async {
    if (selectedContent == 0) {
      generateWallet();
    } else if (selectedContent == 1) {
      generateBrainWallet();
    }

    isPlaying = !isPlaying;

    setState(() {});
  }

  void generateWallet() async {
    if (isPlaying && onRandomWalletsThread) {
      onRandomWalletsThread = false;
      randomWalletsThread?.kill();
      randomWalletsThread = null;
    } else if (isPlaying == false && onRandomWalletsThread == false) {
      showAlert();
      BitcoinLib bitcoin = BitcoinLib();

      final receivePort = ReceivePort();
      Map<String, Object> params = {};
      params["sendPort"] = receivePort.sendPort;
      params["walletsPerSecond"] = WalletStats.walletsPerSecond;

      onRandomWalletsThread = true;
      randomWalletsThread = await Isolate.spawn(bitcoin.generateWallet, params);
      receivePort.listen((response) {
        WalletGeneratorState.wallets.add(response);

        if (WalletGeneratorState.wallets.length > 100) {
          WalletGeneratorState.wallets.removeAt(0);
        }

        setState(() {});
      });
    }
  }

  void generateBrainWallet() async {
    if (isPlaying && onRandomBrainWalletsThread) {
      onRandomBrainWalletsThread = false;
      randomBrainWalletsThread?.kill();
      randomBrainWalletsThread = null;
    } else if (isPlaying == false && onRandomBrainWalletsThread == false) {
      showAlert();
      BitcoinLib bitcoin = BitcoinLib();

      final receivePort = ReceivePort();
      Map<String, Object> params = {};
      params["sendPort"] = receivePort.sendPort;
      params["brainwalletsPerSecond"] = WalletStats.brainwalletsPerSeconds;

      onRandomBrainWalletsThread = true;
      randomBrainWalletsThread =
          await Isolate.spawn(bitcoin.generateBrainWallet, params);
      receivePort.listen((response) {
        WalletGeneratorState.brainWallets.add(response);

        if (WalletGeneratorState.brainWallets.length > 100) {
          WalletGeneratorState.brainWallets.removeAt(0);
        }

        setState(() {});
      });
    }
  }

  void restartThreads() async {
    if (isPlaying) {
      if (onRandomWalletsThread) {
        randomWalletsThread?.kill();
        BitcoinLib bitcoin = BitcoinLib();

        final receivePort = ReceivePort();
        Map<String, Object> params = {};
        params["sendPort"] = receivePort.sendPort;
        params["walletsPerSecond"] = WalletStats.walletsPerSecond;

        onRandomWalletsThread = true;
        randomWalletsThread =
            await Isolate.spawn(bitcoin.generateWallet, params);
        receivePort.listen((response) {
          WalletGeneratorState.wallets.add(response);
          setState(() {});
        });
      }

      if (onRandomBrainWalletsThread) {
        randomBrainWalletsThread?.kill();
        BitcoinLib bitcoin = BitcoinLib();

        final receivePort = ReceivePort();
        Map<String, Object> params = {};
        params["sendPort"] = receivePort.sendPort;
        params["brainwalletsPerSecond"] = WalletStats.brainwalletsPerSeconds;

        onRandomBrainWalletsThread = true;
        randomBrainWalletsThread =
            await Isolate.spawn(bitcoin.generateBrainWallet, params);
        receivePort.listen((response) {
          WalletGeneratorState.brainWallets.add(response);
          setState(() {});
        });
      }
    }
  }

  void showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "OK",
                    textAlign: TextAlign.center,
                  )),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 70, 77, 80),
                  )),
            ),
          ],
          content: const Text(
            "Don't worry, the Bitcoin wallet generation will stop automatically if it finds a wallet with balance in it",
            style: TextStyle(color: Colors.white, fontSize: 17.5),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color.fromARGB(255, 48, 56, 59),
        );
      },
    );
  }
}
