#!/bin/bash

# clean channel-artifacts directory
rm ./channel-artifacts/*
rm -rf ./crypto-config

# generate crypto-config
cryptogen generate --config=./crypto-config.yaml

# tell configtxgen tool where to look for the configtx.yaml
export FABRIC_CFG_PATH=$PWD

# create genesis block for etcdraft channel
configtxgen -profile SampleMultiNodeEtcdRaft -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block

# create channel.tx for channel
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID testchannel

# set anchor peer
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID testchannel -asOrg Org1MSP
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID testchannel -asOrg Org2MSP


