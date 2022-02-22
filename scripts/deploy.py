from brownie import accounts , config , Venom , network

def get_account():
    return accounts.add(config["wallets"]["from_key"])

def deploy_venom():
    account = get_account()
    venom = Venom.deploy({"from" : account}) 

def main():
    deploy_venom()