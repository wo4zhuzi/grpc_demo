#!/bin/bash
cd `dirname $0`

#--go_out : 指定输出go代码
#plugins=grpc : 为protoc-gen-go插件的工作方式 .proto文件中的service是grpc的扩展功能，需要使用grpc插件进行解析才能生成对应的接口定义代码。
#./pb为gout_out 的第二个参数，为go代码生成的位置
protoc  --go_out=plugins=grpc:./pb ./foo.proto