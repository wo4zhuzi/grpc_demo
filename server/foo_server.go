package main

import (
	"context"
	"fmt"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"grpc_demo/protobuf/pb"
	"net"
)

type fooServer struct {
}

func (s *fooServer) Hello(ctx context.Context, in *pb.HelloReq) (*pb.HelloRes, error) {
	return &pb.HelloRes{Msg: in.Msg}, nil
}

func main() {

	//监听本地端口
	lis, err := net.Listen("tcp", ":8080")
	if err != nil {
		fmt.Printf("监听端口失败: %s", err)
		return
	}

	//创建gRPC 服务
	s := grpc.NewServer()

	//注册服务
	pb.RegisterFooServer(s, &fooServer{})
	reflection.Register(s)
	err = s.Serve(lis)

	if err != nil {
		fmt.Printf("开启服务失败: %s", err)
		return
	}
}
