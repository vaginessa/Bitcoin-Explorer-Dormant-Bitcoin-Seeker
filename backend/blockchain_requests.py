import requests
import json

base_url = "https://blockchain.info/balance?cors=true&active="

def getWalletBalance(wallets) :
    url = base_url

    for wallet in wallets :
        url += wallets[wallet]["address"] + ","

    response = requests.get(url)
    response = json.loads(response.text)

    for wallet in wallets :
        wallets[wallet]["balance"] = response[wallets[wallet]["address"]]["final_balance"]

    return wallets

    



