# 2org4peer 
## Procedure

### 1. crypto & channel-artifacts 생성
$ sh generate.sh
(이미 생성되어 있어 굳이 실행시키지 않아도 됨)
(실행해도 상관없음)


### 2. 블록체인 네트워크 실행
$ sh run.sh

2org4peer와 couchdb, cli로 구성된 네트워크를 실행한다.


### 3. cli container로 이동
$ docker exec -it cli bash

peer에 명령어를 날리기 위해 cli container 안으로 이동


### 4. 채널 생성 및 조인
$ sh scripts/createChannelAndJoin.sh

cli 안에 기 작성되어 있는 채널 생성 및 조인 스크립트 실행


### 5. 체인코드 install 및 instantiate
$ sh scripts/installAndInstantiateChaincode.sh

cli 안에 기 작성되어 체인코드 install, instantiate 스크립트 실행


### 6. invoke 
#### createAuctioner invoke
$ peer chaincode invoke -o orderer1.auction.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/auction.com/orderers/orderer1.auction.com/msp/tlscacerts/tlsca.auction.com-cert.pem -C $CHANNEL_NAME -n participants --peerAddresses peer0.org1.auction.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/peers/peer0.org1.auction.com/tls/ca.crt --peerAddresses peer0.org2.auction.com:9051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/peers/peer0.org2.auction.com/tls/ca.crt -c '{"Args":["createAuctioner","ID01","James","0"]}'

#### createBidder invoke
$ peer chaincode invoke -o orderer1.auction.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/auction.com/orderers/orderer1.auction.com/msp/tlscacerts/tlsca.auction.com-cert.pem -C $CHANNEL_NAME -n participants --peerAddresses peer0.org1.auction.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.auction.com/peers/peer0.org1.auction.com/tls/ca.crt --peerAddresses peer0.org2.auction.com:9051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.auction.com/peers/peer0.org2.auction.com/tls/ca.crt -c '{"Args":["createBidder","ID02","Tom","0"]}'

### 7. query
#### getAuctioner query
$ peer chaincode query -C $CHANNEL_NAME -n participants -c '{"Args":["getAuctioner","ID01"]}'

#### getBidder query
$ peer chaincode query -C $CHANNEL_NAME -n participants -c '{"Args":["getBidder","ID02"]}'

