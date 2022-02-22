from brownie import Venom , accounts , config , config

def get_account():
    return accounts.add(config["wallets"]["from_key"])

def generate() :
    account = get_account()
    venom = Venom[-1]
    venom.generateVenom({"from": account})

def main() :
    generate()