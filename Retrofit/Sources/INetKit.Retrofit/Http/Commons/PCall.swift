//
//  PCall.swift
//  INetKit.Retrofit
//
//  Created by Taiyou on 2025/7/11.
//

protocol PCall<T>{
    func execute() async throws -> T//MResultIST<Data>
}

public protocol PCallFactory{
    func newCall(retrofit:PRetrofit) -> any PCall<Any>
}
