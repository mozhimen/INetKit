//
//  PJsonFormatter.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/4.
//
import Foundation

open class PRequestConverter {
    func convert<F:Encodable>(_ from:F) throws -> Data? {
        return nil
    }
}

open class PResponseConverter {
    func convert<T:Decodable>(_ from:Data) throws -> T? {
        return nil
    }
}

public protocol PConverterFactory{
    func resquestBodyConverter() -> PRequestConverter?
    func responseBodyConverter() -> PResponseConverter?
}
