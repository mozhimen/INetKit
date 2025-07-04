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
    associatedtype F
    associatedtype T
    func responseBodyConverter() -> any PConverter<F,T,J>
    func resquestBodyConverter() -> any PConverter<T,F,J>
}
