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
..../peer/# sh scripts/createChannelAndJoin.sh

cli 안에 기 작성되어 있는 채널 생성 및 조인 스크립트 실행


### 5. 체인코드 install 및 instantiate
..../peer/# sh scripts/installAndInstantiateChaincode.sh

cli 안에 기 작성되어 체인코드 install, instantiate 스크립트 실행


### 6. invoke 
