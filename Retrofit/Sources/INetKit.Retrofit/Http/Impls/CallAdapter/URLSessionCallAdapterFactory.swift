//
//  AsyncCallAdapter.swift
//  INetKit.Retrofit
//
//  Created by Taiyou on 2025/7/11.
//

class URLSessionCallAdapterFactory: PCallAdapterFactory{
    func get(retrofit: any PRetrofit) -> (any PCallAdapter<Any,Any>) {
        return retrofit
    }
}

