from web3 import Web3, HTTPProvider
from solc import compile_standard, compile_files, compile_source
import os
from populus.utils.filesystem import recursive_find_files


compiled_contracts = compile_source(open('main.sol', 'r').read())

"""
compiled_sol = compile_files({
        'main.sol': {
            'urls': ['./main.sol']
        },
        'student.sol': {
            'urls': ['./student.sol']
        },
        'company.sol': {
            'urls': ['./company.sol']
        }

}, output_dir="./", bin=True, allow_paths="./")"""

# contract_interface = compiled_sol['<stdin>:Main']
w3 = Web3(HTTPProvider("http://127.0.0.1:8888"))
print(w3.isConnected())
# contract = w3.eth.contract(abi=contract_interface['abi'], bytecode=contract_interface['bin'])
