/*
Copyright IBM Corp. 2016 All Rights Reserved.
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
		 http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package main

import (
	"encoding/json"
	"fmt"
	"strconv"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

// ParticipantsChaincode example simple Chaincode implementation
type ParticipantsChaincode struct {
}

// Init Participants chaincode
func (t *ParticipantsChaincode) Init(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("Participants chaincode start.")
	return shim.Success(nil)
}

// Invoke Participants chaincode
func (t *ParticipantsChaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("Participants chaincode Invoke")
	function, args := stub.GetFunctionAndParameters()
	if function == "createAuctioner" {
		return t.creaetAuctioner(stub, args)
	} else if function == "createBidder" {
		return t.createBidder(stub, args)
	}

	return shim.Error("Invalid invoke function name.")
}

func (t *ParticipantsChaincode) creaetAuctioner(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	fmt.Println("Participants > createAuctioner start")

	// validation
	if len(args) != 3 {
		lenArgs := strconv.Itoa(len(args))
		fmt.Println("Participants > createAuctioner > Error: require 3 args but " + lenArgs + " args input")
		return shim.Error("require 3 args but " + lenArgs + " args input")
	}

	id := args[0]
	name := args[1]
	balance := args[2]

	key := id + "_Auctioner"

	participantAsBytes, err := stub.GetState(key)
	if err != nil {
		fmt.Println("Participants > createAuctioner > Error: " + err.Error())
		return shim.Error(err.Error())
	} else if participantAsBytes != nil {
		fmt.Println("Participants > createAuctioner > Error: Participant " + key + " already exists")
		return shim.Error("Participant " + key + " already exists")
	}

	participant := Participant{
		ID:      id,
		Name:    name,
		Role:    "Auctioneer",
		Balance: balance,
	}

	participantAsJSONBytes, err := json.Marshal(participant)
	if err != nil {
		fmt.Println("Participants > createAuctioner > Error: " + err.Error())
		return shim.Error(err.Error())
	}

	err = stub.PutState(key, participantAsJSONBytes)
	if err != nil {
		fmt.Println("Participants > createAuctioner > Error: " + err.Error())
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

func (t *ParticipantsChaincode) createBidder(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	fmt.Println("Participants > createBidder start")

	// validation
	if len(args) != 3 {
		lenArgs := strconv.Itoa(len(args))
		fmt.Println("Participants > createBidder > Error: require 3 args but " + lenArgs + " args input")
		return shim.Error("require 3 args but " + lenArgs + " args input")
	}

	id := args[0]
	name := args[1]
	balance := args[2]

	key := id + "_Bidder"

	participantAsBytes, err := stub.GetState(key)
	if err != nil {
		fmt.Println("Participants > createBidder > Error: " + err.Error())
		return shim.Error(err.Error())
	} else if participantAsBytes != nil {
		fmt.Println("Participants > createBidder > Error: Participant " + key + " already exists")
		return shim.Error("Participant " + key + " already exists")
	}

	participant := Participant{
		ID:      id,
		Name:    name,
		Role:    "Bidder",
		Balance: balance,
	}

	participantAsJSONBytes, err := json.Marshal(participant)
	if err != nil {
		fmt.Println("Participants > createBidder > Error: " + err.Error())
		return shim.Error(err.Error())
	}

	err = stub.PutState(key, participantAsJSONBytes)
	if err != nil {
		fmt.Println("Participants > createBidder > Error: " + err.Error())
		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

func (t *ParticipantsChaincode) getAuctioner(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	fmt.Println("Participants > getAuctioner start")

	// validation
	if len(args) != 1 {
		lenArgs := strconv.Itoa(len(args))
		fmt.Println("Participants > getAuctioner > Error: require 1 args but " + lenArgs + " args input")
		return shim.Error("require 1 args but " + lenArgs + " args input")
	}

	id := args[0]

	key := id + "_Auctioner"

	participantAsBytes, err := stub.GetState(key)
	if err != nil {
		fmt.Println("Participants > getAuctioner > Error: " + err.Error())
		return shim.Error(err.Error())
	} else if participantAsBytes == nil {
		fmt.Println("Participants > getAuctioner > Error: Participant " + key + " is not exists")
		return shim.Error("Participant " + key + " is not exists")
	}

	fmt.Println("Participants > getAuctioner > result:" + string(participantAsBytes))
	return shim.Success(participantAsBytes)
}

func (t *ParticipantsChaincode) getBidder(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	fmt.Println("Participants > getBidder start")

	// validation
	if len(args) != 1 {
		lenArgs := strconv.Itoa(len(args))
		fmt.Println("Participants > getBidder > Error: require 1 args but " + lenArgs + " args input")
		return shim.Error("require 1 args but " + lenArgs + " args input")
	}

	id := args[0]

	key := id + "_Auctioner"

	participantAsBytes, err := stub.GetState(key)
	if err != nil {
		fmt.Println("Participants > getBidder > Error: " + err.Error())
		return shim.Error(err.Error())
	} else if participantAsBytes == nil {
		fmt.Println("Participants > getBidder > Error: Participant " + key + " is not exists")
		return shim.Error("Participant " + key + " is not exists")
	}

	fmt.Println("Participants > getBidder > result:" + string(participantAsBytes))
	return shim.Success(participantAsBytes)
}

func main() {
	err := shim.Start(new(ParticipantsChaincode))
	if err != nil {
		fmt.Printf("Error starting Participants chaincode: %s", err)
	}
}
