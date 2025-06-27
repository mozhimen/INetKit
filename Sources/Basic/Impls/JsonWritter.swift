//
//  JsonWritter.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/27.
//
import Foundation

public struct JsonWriter: PJsonWriter {
    //mark: Life Cycle
    public init(){}
    
    //mark: api methods
    
    /// Encode data to send
    /// - Parameter items: Input data
    /// - Returns: Returns a JSON-encoded representation of the value you supply.
    public func toJson<T:Encodable>(_ item: T) throws -> Data {
        try JSONEncoder().encode(item)
    }
}
