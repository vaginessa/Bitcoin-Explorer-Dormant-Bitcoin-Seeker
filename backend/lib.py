import bitcoin
import blockchain_requests
import utils

def randomWallet(totalAddresses) :
    wallets = {}

    for n in range(0,int(totalAddresses)) :
        privKey = bitcoin.random_key()
        pubKey = bitcoin.privkey_to_pubkey(privKey)
        address = bitcoin.pubkey_to_address(pubKey)

        wallets[str(n)] = {
            "privateKey" : privKey,
            "publicKey" : pubKey,
            "address" : address
        }

        wallets = blockchain_requests.getWalletBalance(wallets)

    return wallets

def randomBrainwallet(totalAddresses) : 
    wallets = {}

    for n in range(0,int(totalAddresses)) :
        seed = utils.random_seed_phrase()
        privKey = utils.bip39(seed)
        pubKey = bitcoin.privkey_to_pubkey(privKey)
        address = bitcoin.pubkey_to_address(pubKey)

        wallets[str(n)] = {
            "seed" : seed,
            "privateKey" : privKey,
            "publicKey" : pubKey,
            "address" : address
        }

        wallets = blockchain_requests.getWalletBalance(wallets)

    return wallets

