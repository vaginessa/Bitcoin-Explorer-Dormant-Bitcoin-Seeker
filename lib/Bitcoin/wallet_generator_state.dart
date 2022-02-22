import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/bitcoin.dart';
import 'package:dormant_bitcoin_seeker_flutter/Shared/bitcoin_wallet_card.dart';

import '../Models/bitcoin_wallet.dart';

class WalletGeneratorState
{
  static List<BitcoinWalletCard> wallets = [];
  static List<BitcoinWalletCard> brainWallets = [];
  static List<BitcoinWalletCard> cardsQueue = [];

  static Future<void> generate() async{
    BitcoinWallet wallet = Bitcoin.generateWallet();
    BitcoinWalletCard card = BitcoinWalletCard(wallet: wallet);
    await wallet.request();
    wallets.add(card);
  }

  static Future<void> generateBrainWallet() async{
    BitcoinWallet wallet = Bitcoin.generateBrainWallet();
    BitcoinWalletCard card = BitcoinWalletCard(wallet: wallet);
    await wallet.request();
    brainWallets.add(card);
  }
}