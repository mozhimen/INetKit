//
//  Retroft.swift
//  INetKit.Retrofit
//
//  Created by Taiyou on 2025/7/11.
//

open class Retroft:PRetrofit{
    public func setConverterFactory(converterFactory: any PConverterFactory) {
        self.converterFactory = converterFactory
    }
    
    public func setCallAdapterFactory(callAdapterFactory: any PCallAdapterFactory) {
        self.callAdapterFactory = callAdapterFactory
    }
}
