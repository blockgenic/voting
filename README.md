# EOS Block Producer Voting guide
This guide shows how to vote for a producer on EOS

## Get the binaries
The first step is to get the recommended binaries. The recommended OS is Ubuntu 16.04 LTS and pre-build binaries are provided in this repository for users of Ubuntu.  
Run the following commands to obtain the binaries  
*wget https://github.com/blockgenic/binaries/raw/master/cleos*  
*wget https://github.com/blockgenic/binaries/raw/master/cleos*  
If you have a Windows 10 machine you can install the Windows subsystem for Linux (along with the Ubuntu subsystem app) by following our guide here then downloading the binaries:  
https://medium.com/@blockgenic/eosio-single-node-testnet-setup-on-windows-ae7a59900e69  
If neither option is available then you can build your own binaries by using the EOS build script buildeos.sh that we have provided in this repo. Note that it might take a while to install all the dependencies and complete the build.  
The script builds all the EOS binaries and copies cleos and keosd (which are the binaries required for voting) to the local folder. cleos is a command line interface to EOS. keosd is a wallet daemon that securely manages private key operations based on an encrypted wallet file that contains your private key.   
Once the build is complete type ls -l on the command line to verify that both keosd and cleos are present in the current folder.  

## Start the wallet daemon, create the default wallet and import your private key(s) into the encrypted wallet
The following command starts the wallet daemon  
*./keosd &> ./keosd.log &*  
You can then verify that it is up and running  
*tail ./keosd.log*  
Then create the default wallet  
*./cleos --wallet-url http://localhost:8888/ wallet create*  
This should output a random password for the encrypted wallet. You may save the password if you plan to reuse the wallet. BlockGenic recommends destroying the wallet once you have voted and continuing to keep your private keys in cold storage in which case this password will not be needed.  
Run the following command to import your EOS private key that you obtained when you registered your EOS  
*./cleos --wallet-url http://localhost:8888/ wallet import 5KTDQ5mBXyRjUpnURPsWyJ1qkrPyiBvcXTmiEdftsEicZWHqRoT*  
where the long string starting with 5KTD... is your private key.  
Repeat for all the private keys you need to import for all your accounts.  

## Connect to the EOS network and vote for your favorite producer
First connect and verify that the node is running  
*./cleos  --url http://api.blockgenicbp.com:8888 get info*  
You should see info about the node such as server version etc.  
Next ensure you can query your account by using your account name. Each EOS public key was assigned a randomly created account name. You can find the name associated with your public key by searching for your public key in the EOS snapshot. It will be a random 12 digit alphabetic name.  
We have made the EOS snapshot available here:  
https://raw.githubusercontent.com/blockgenic/voting/master/snapshot.csv  
Once you have the account name query your account by running the following command  
*./cleos--url http://api.blockgenicbp.com:8888 get account accountname1*  
You will notice that 10 EOS is left in your balance and the remaining have been evenly staked for CPU and Bandwidth. 
Check all your accounts corresponding to all your public keys.  
Now you are ready to vote. The next command will vote for your chosen producer. Your private key remains on your machine and is only used to sign your vote for validation.  
*cleos --wallet-url http://localhost:8888 --url http://api.blockgenicbp.com:8888 system voteproducer prods youraccountname1 blockgenicbp*  
Repeat the last command for each account name associated with your account.  
You can also verify that your vote has been counted by repeating the cleos get account command for your accounts. You should see the producer name blockgenicbp.
