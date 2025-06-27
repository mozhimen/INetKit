//
//  JsonReader.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/27.
//
import Foundation

public struct JsonReader: PJsonReader{
    //Life circle
    public init() {}
    
    //mark: API Methods
    
    /// Parse JSON data
    /// - Parameter data: Fetched data
    /// - Returns: Returns a value of the type you specify, decoded from a JSON object.
    public func fromJson<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
