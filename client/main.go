package main

import (
	"context"
	"google.golang.org/grpc"
	"grpc_demo/protobuf/pb"
	"log"
)

func main()  {
	conn, _ := grpc.Dial("127.0.0.1:8080", grpc.WithInsecure())
	defer conn.Close()

	client := pb.NewFooClient(conn)
	res, _:= client.Hello(context.Background(), &pb.HelloReq{Msg: "123"})

	log.Println("res", res.GetMsg())

	res, _= client.Hello(context.Background(), &pb.HelloReq{Msg: "1234"})
	log.Println("res", res.GetMsg())

}
