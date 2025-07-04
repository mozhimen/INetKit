//
//  JSONEncoderResponseConverter.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/4.
//
import Foundation

class JSONDecoderResponseConverter<T:Decodable> : PConverter{
    var convertor: JSONDecoder
    
    init(converter:JSONDecoder) {
        self.convertor = converter
    }
    
    func convert(_ from: Data) throws -> T {
        try convertor.decode(T.self, from: from)
    }
}
