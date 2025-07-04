//
//  JSONDecoderRequestBodyConverter.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/4.
//
import Foundation

class JSONEncoderRequestBodyConverter<F:Encodable> :PConverter{
    var convertor: JSONEncoder
    
    init(convertor: JSONEncoder) {
        self.convertor = convertor
    }
    
    func convert(_ from: F) throws -> Data {
        try convertor.encode(from)
    }
}
