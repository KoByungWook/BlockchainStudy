#!/bin/bash

# set peer0.org1 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/users/Admin@org1.auction.com/msp
CORE_PEER_ADDRESS=peer0.org1.auction.com:7051
CORE_PEER_LOCALMSPID="Org1MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/peers/peer0.org1.auction.com/tls/ca.crt

# peer0.org1 install chaincode
peer chaincode install -n participants -v 1.0 -p github.com/chaincode/participants

# set peer1.org1 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/users/Admin@org1.auction.com/msp
CORE_PEER_ADDRESS=peer1.org1.auction.com:8051
CORE_PEER_LOCALMSPID="Org1MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/peers/peer1.org1.auction.com/tls/ca.crt

# peer1.org1 install chaincode
peer chaincode install -n participants -v 1.0 -p github.com/chaincode/participants

# set peer0.org2 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/users/Admin@org2.auction.com/msp
CORE_PEER_ADDRESS=peer0.org2.auction.com:9051
CORE_PEER_LOCALMSPID="Org2MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/peers/peer0.org2.auction.com/tls/ca.crt

# peer0.org2 install chaincode
peer chaincode install -n participants -v 1.0 -p github.com/chaincode/participants

# set peer1.org2 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/users/Admin@org2.auction.com/msp
CORE_PEER_ADDRESS=peer1.org2.auction.com:10051
CORE_PEER_LOCALMSPID="Org2MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/peers/peer1.org2.auction.com/tls/ca.crt

# peer1.org2 install chaincode
peer chaincode install -n participants -v 1.0 -p github.com/chaincode/participants

# set peer0.org1 peer environment
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/users/Admin@org1.auction.com/msp
CORE_PEER_ADDRESS=peer0.org1.auction.com:7051
CORE_PEER_LOCALMSPID="Org1MSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/peers/peer0.org1.auction.com/tls/ca.crt

# peer0.org1 instantiate chaincode
peer chaincode instantiate -o orderer1.auction.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/auction.com/orderers/orderer1.auction.com/msp/tlscacerts/tlsca.auction.com-cert.pem -C $CHANNEL_NAME -n participants -v 1.0 -c '{"Args":["init"]}' -P "AND ('Org1MSP.peer','Org2MSP.peer')"
