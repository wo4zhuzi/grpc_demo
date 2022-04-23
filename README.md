### 如何使用

- 编写.proto文件
- 利用工具将.proto文件生成对应语言的代码
- 根据生成的代码编写服务端和客户端的代码
-

文档[https://developers.google.com/protocol-buffers/docs/gotutorial](https://developers.google.com/protocol-buffers/docs/gotutorial)

### 准备工作

首先安装将.proto文件生成对应代码的工具，下载地址 [https://github.com/protocolbuffers/protobuf/releases](https://github.com/protocolbuffers/protobuf/releases)

#### 二进制安装 protoc

下载

```
wget https://github.com/protocolbuffers/protobuf/releases/download/v3.19.4/protoc-3.19.4-osx-x86_64.zip

unzip protoc-3.19.4-osx-x86_64.zip
```

建立软连接

```
sudo ln -s /Users/kongdebo/Documents/application/protoc-3.19.4-osx-x86_64/bin/protoc /usr/local/bin/protoc
```

#### 安装 protoc-gen-go 插件

```
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
```

#### 安装 protoc-gen-go-grpc 插件

```shell
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

### 编写服务和使用

#### Demo

项目地址 [https://github.com/wo4zhuzi/grpc_demo](https://github.com/wo4zhuzi/grpc_demo)

目录结构

```text
.
├── README.md
├── client
│   └── main.go
├── go.mod
├── go.sum
├── protobuf
│   ├── build.sh
│   ├── foo.proto
│   └── pb
│       ├── foo.pb.go
│       └── foo_grpc.pb.go
└── server
    └── main.go

```

#### 生成代码

```shell
cd protobuf
protoc  --go_out=. --go_opt=paths=import --go-grpc_out=. --go-grpc_opt=paths=import  ./foo.proto
```

#### 参数解释

+ paths=import : paths参数有两个选项，import 和 source_relative
+ 默认为import，表示按照生成go代码的包的全路径去创建目录层级，source_relative表示按照proto源文件目录层级去创建go代码目录层级
+ 例：
+ 如果foo.proto 文件中，参数为 option go_package = "./pb;pb";
+ 设置paths=import 代码生成在 ./protobuf/pb， 而设置 paths=source_relative 则，代码生成在./protobuf文件夹下

#### 运行服务端代码

```shell
cd server
go run main.go
```

#### 运行客户端代码

```shell
cd client
go run main.go
```

#### 运行结果

```text
2022/04/23 11:13:58 res 123
2022/04/23 11:13:58 res 1234
```

### 版本问题

#### 老版本

```shell
go get github.com/golang/protobuf/protoc-gen-go 
```

如果是通过一下方式安装 protoc-gen-go，则生成的版本为 v1.26.0

该版本生成命令为

```shell
protoc  --go_out=plugins=grpc,paths=import:./ ./foo.proto
```

#### 参数解释

+ --go_out : 指定输出go代码， --go_out的写法是参数之间用逗号隔开，最后加上冒号来指定代码生成的位置
+ plugins=grpc : 为protoc-gen-go插件的工作方式 .proto文件中的service是grpc的扩展功能，需要使用grpc插件进行解析才能生成对应的接口定义代码。
+ paths=import : paths参数有两个选项，import 和 source_relative
+ 默认为import，表示按照生成go代码的包的全路径去创建目录层级，source_relative表示按照proto源文件目录层级去创建go代码目录层级
+ 例：
+ 如果foo.proto 文件中，参数为 option go_package = "./pb;pb";
+ 设置paths=import 代码生成在 ./protobuf/pb， 而设置 paths=source_relative 则，代码生成在./protobuf文件夹下

#### 新老版本区别
老版本生成一个文件 foo.pb.go， 而新版本引入了foo_grpc.pb.go，把foo.pb.go文件中的client
和server相关的代码提取到了foo_grpc.pb.go中。并引入了 mustEmbedUnimplemented 方法，他的目的是用于向前兼容的。
具体可参见 [https://stackoverflow.com/questions/65079032/grpc-with-mustembedunimplemented-method](https://stackoverflow.com/questions/65079032/grpc-with-mustembedunimplemented-method)


