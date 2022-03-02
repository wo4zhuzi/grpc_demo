### 如何使用
- 编写.proto文件
- 利用工具将.proto文件生成对应语言的代码
- 根据生成的代码编写服务端和客户端的代码
- 文档[https://developers.google.com/protocol-buffers/docs/gotutorial](https://developers.google.com/protocol-buffers/docs/gotutorial)

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
go get -u github.com/golang/protobuf/protoc-gen-go
```

#### 安装 grpc
```
go get google.golang.org/grpc
```