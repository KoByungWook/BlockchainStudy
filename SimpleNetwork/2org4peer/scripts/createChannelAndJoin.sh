#!/bin/bash

# set peer0.org1 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/users/Admin@org1.auction.com/msp
CORE_PEER_ADDRESS=peer0.org1.auction.com:7051
CORE_PEER_LOCALMSPID="Org1MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/peers/peer0.org1.auction.com/tls/ca.crt

# export channel name
export CHANNEL_NAME=testchannel

# testchannel create
peer channel create -o orderer1.auction.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/auction.com/orderers/orderer1.auction.com/msp/tlscacerts/tlsca.auction.com-cert.pem

# join peer0.org1s
peer channel join -b testchannel.block

# set peer1.org1 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/users/Admin@org1.auction.com/msp
CORE_PEER_ADDRESS=peer1.org1.auction.com:8051
CORE_PEER_LOCALMSPID="Org1MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/peers/peer1.org1.auction.com/tls/ca.crt

# join peer1.org1
peer channel join -b testchannel.block

# set peer0.org2 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/users/Admin@org2.auction.com/msp
CORE_PEER_ADDRESS=peer0.org2.auction.com:9051
CORE_PEER_LOCALMSPID="Org2MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/peers/peer0.org2.auction.com/tls/ca.crt

# join peer0.org2
peer channel join -b testchannel.block

# set peer1.org2 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/users/Admin@org2.auction.com/msp
CORE_PEER_ADDRESS=peer1.org2.auction.com:10051
CORE_PEER_LOCALMSPID="Org2MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/peers/peer1.org2.auction.com/tls/ca.crt

# join peer0.org2
peer channel join -b testchannel.block

# set peer0.org1 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/users/Admin@org1.auction.com/msp
CORE_PEER_ADDRESS=peer0.org1.auction.com:7051
CORE_PEER_LOCALMSPID="Org1MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/peers/peer0.org1.auction.com/tls/ca.crt

# peer0.org1 update anchor peer
peer channel update -o orderer1.auction.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/Org1MSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/auction.com/orderers/orderer1.auction.com/msp/tlscacerts/tlsca.auction.com-cert.pem

# set peer0.org2 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/users/Admin@org2.auction.com/msp
CORE_PEER_ADDRESS=peer0.org2.auction.com:9051
CORE_PEER_LOCALMSPID="Org2MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/peers/peer0.org2.auction.com/tls/ca.crt

# peer0.org1 update anchor peer
peer channel update -o orderer1.auction.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/Org2MSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/auction.com/orderers/orderer1.auction.com/msp/tlscacerts/tlsca.auction.com-cert.pem
