

import 'package:dormant_bitcoin_seeker_flutter/Bitcoin/bitcoin.dart';
import 'package:dormant_bitcoin_seeker_flutter/Shared/bitcoin_wallet_card.dart';

import '../Models/bitcoin_wallet.dart';

class WalletGeneratorState
{
  static List<BitcoinWalletCard> wallets = [];

  static void generate(){
    BitcoinWallet wallet = Bitcoin.generateWallet();
    wallets.add(BitcoinWalletCard(wallet: wallet));
  }
}