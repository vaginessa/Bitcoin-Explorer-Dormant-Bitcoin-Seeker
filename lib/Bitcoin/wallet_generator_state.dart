import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/bitcoin.dart';
import 'package:dormant_bitcoin_seeker_flutter/Shared/bitcoin_wallet_card.dart';

import '../Models/bitcoin_wallet.dart';

class WalletGeneratorState
{
  static List<BitcoinWalletCard> wallets = [];
  static List<BitcoinWalletCard> cardsQueue = [];

  // static void generate(){
  //   BitcoinWallet wallet = Bitcoin.generateWallet();
  //   BitcoinWalletCard card = BitcoinWalletCard(wallet: wallet);
  //   wallet.cardIndex = cardsQueue.length;
  //   cardsQueue.add(card);
  // }

  // static void removeFromQueue(int cardIndex){
  //   wallets.add(cardsQueue[cardIndex]);
  //   cardsQueue.removeAt(cardIndex);
  // }

  static Future<void> generate() async{
    BitcoinWallet wallet = Bitcoin.generateWallet();
    BitcoinWalletCard card = BitcoinWalletCard(wallet: wallet);
    await wallet.request();
    wallets.add(card);
  }
}