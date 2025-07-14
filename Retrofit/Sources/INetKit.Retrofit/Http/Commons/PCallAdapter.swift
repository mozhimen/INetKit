//
//  PCallAdapter.swift
//  INetKit.Retrofit2
//
//  Created by Taiyou on 2025/7/11.
//

//public protocol PCallAdapter{
//    func request(with requestBuilder: RequestBuilder) async throws -> ENetKRes//MResultIST<Data>
//}

public protocol PCallAdapter<REQ,RES>{
    associatedtype REQ
    associatedtype RES
    func call(request :REQ) async throws -> RES//MResultIST<Data>
}


public protocol PCallAdapterFactory{
    func get() -> any PCallAdapter<Request,Response>
}
