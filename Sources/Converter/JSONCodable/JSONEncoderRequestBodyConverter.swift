//
//  JSONDecoderRequestBodyConverter.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/4.
//
import Foundation

class JSONEncoderRequestBodyConverter :PConverter {
    typealias F = Any
    typealias T = PRequestBody
    private let jsonEncoder: JSONEncoder
    
    init(jsonEncoder: JSONEncoder) {
        self.jsonEncoder = jsonEncoder
    }
        
    func convert(_ from: F) throws ->  PRequestBody {
        guard let encodable = from as? any Encodable else {
            throw EncodingError.invalidValue(from, EncodingError.Context(codingPath: [], debugDescription: "Type \(type(of: from)) is not Encodable"))
           }
        let to = try jsonEncoder.encode(encodable)
        return RequestBody.create(data: to)
    }
}
