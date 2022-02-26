from flask import Flask
from flask import request
import lib

app = Flask(__name__)

@app.route("/randomWallets",methods = ['GET'])
def randomWallet() :
    return lib.randomWallet(request.args.get("totalAddresses"))

@app.route("/randomBrainwallets",methods = ['GET'])
def randomBrainwallet() :
    return lib.randomBrainwallet(request.args.get("totalAddresses"))

if __name__ == "__main__" :
    app.run(debug=True)