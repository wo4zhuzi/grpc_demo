#!/bin/bash
cd `dirname $0`

protoc  --go_out=plugins=grpc:./pb ./foo.proto