import random
import mnemonic
import bip32utils
import base58
import binascii

def random_seed_phrase() :
    file = open("./english.txt","r")
    seed_phrase = ""
    words = []
    for word in file.readlines() :
        words.append(word.rstrip("\n"))

    for n in range(0,12) :
        seed_phrase += words[random.randint(0,len(words)-1)]
        if(n < 10) :
            seed_phrase += " "
            
            
    return seed_phrase

def bip39(mnemonic_words):
    mobj = mnemonic.Mnemonic("english")
    seed = mobj.to_seed(mnemonic_words)

    bip32_root_key_obj = bip32utils.BIP32Key.fromEntropy(seed)
    bip32_child_key_obj = bip32_root_key_obj.ChildKey(
        44 + bip32utils.BIP32_HARDEN
    ).ChildKey(
        0 + bip32utils.BIP32_HARDEN
    ).ChildKey(
        0 + bip32utils.BIP32_HARDEN
    ).ChildKey(0).ChildKey(0)

    wif = bip32_child_key_obj.WalletImportFormat()
    private_key = wif_to_privkey(wif)

    return private_key

def wif_to_privkey(wif):    
    first_encode = base58.b58decode(wif)
    private_key_full = binascii.hexlify(first_encode)
    private_key = private_key_full[2:-10]
    return private_key.decode("utf-8")