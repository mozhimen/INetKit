//
//  JSONDecoderRequestBodyConverter.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/4.
//
import Foundation

class JSONEncoderRequestBodyConverter: PRequestConverter {
    typealias F = Any
    typealias T = Data
    private let _jsonEncoder: JSONEncoder
    
    init(jsonEncoder: JSONEncoder) {
        self._jsonEncoder = jsonEncoder
    }
        
    override func convert<F>(_ from: F) throws -> Data? where F : Encodable {
        return try _jsonEncoder.encode(from)
    }
}
