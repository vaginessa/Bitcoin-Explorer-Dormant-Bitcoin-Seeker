import 'package:dormant_bitcoin_seeker_flutter/Shared/bitcoin_wallet_card.dart';

class WalletGeneratorState{
  static List<BitcoinWalletCard> wallets = [];
  static List<BitcoinWalletCard> brainWallets = [];
  static BitcoinWalletCard? searchResultByAddress;
  static BitcoinWalletCard? searchResultByPrivateKey;
  static BitcoinWalletCard? searchResultBySeedPhrase;
}