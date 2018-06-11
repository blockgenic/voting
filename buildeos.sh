git clone --branch launch-rc-1.0.2  https://github.com/EOS-Mainnet/eos/
cd eos
git fetch && git fetch --tags
git checkout mainnet-1.0.2.2
git submodule update --init --recursive
./eosio_build.sh
