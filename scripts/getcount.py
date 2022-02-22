from brownie import Venom , accounts , config , config

def get_account():
    return accounts.add(config["wallets"]["from_key"])

def retrieve() :
    account = get_account()
    venom = Venom[-1]
    count = venom.getCountOfVenoms({"from": account})
    print(count)

def main() :
    retrieve()