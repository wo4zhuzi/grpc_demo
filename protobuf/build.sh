#!/bin/bash
cd `dirname $0`

###--- 老版本
#--go_out : 指定输出go代码， --go_out的写法是参数之间用逗号隔开，最后加上冒号来指定代码生成的位置
#plugins=grpc : 为protoc-gen-go插件的工作方式 .proto文件中的service是grpc的扩展功能，需要使用grpc插件进行解析才能生成对应的接口定义代码。
#paths=import : paths参数有两个选项，import 和 source_relative
#默认为import，表示按照生成go代码的包的全路径去创建目录层级，source_relative表示按照proto源文件目录层级去创建go代码目录层级
#例：
#如果foo.proto 文件中，参数为 option go_package = "./pb;pb";
#设置paths=import 代码生成在 ./protobuf/pb， 而设置 paths=source_relative 则，代码生成在./protobuf文件夹下

#protoc  --go_out=plugins=grpc,paths=import:./ ./foo.proto

###--- 老版本



### ---新版本
protoc  --go_out=. --go_opt=paths=import --go-grpc_out=. --go-grpc_opt=paths=import  ./foo.proto
### ---新版本