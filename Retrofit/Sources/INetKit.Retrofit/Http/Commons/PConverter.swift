//
//  PJsonFormatter.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/4.
//

public protocol PConverter<F,T> {
    associatedtype F
    associatedtype T

    func convert(_ from:F) throws -> T
}

public protocol PConverterFactory{
    func resquestBodyConverter() -> (any PConverter<Any,Data>)?
    func responseBodyConverter() -> (any PConverter<Data,Any>)?
}
