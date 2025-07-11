//
//  PCallAdapter.swift
//  INetKit.Retrofit2
//
//  Created by Taiyou on 2025/7/11.
//

//public protocol PCallAdapter{
//    func request(with requestBuilder: RequestBuilder) async throws -> ENetKRes//MResultIST<Data>
//}

public protocol PCallAdapter<R,T>{
    func adapt(call: PCall<R>) async throws -> T//MResultIST<Data>
}


public protocol PCallAdapterFactory{
    func get(retrofit: PRetrofit) -> any PCallAdapter<Any,Any>
}
