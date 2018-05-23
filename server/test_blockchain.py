from web3 import Web3, HTTPProvider

w3 = Web3(HTTPProvider("http://127.0.0.1:8888"))
print(w3.isConnected())
