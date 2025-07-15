//
//  JSONEncoderResponseConverter.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/4.
//
import Foundation

class JSONDecoderResponseConverter : PResponseConverter {
    private let _jsonDecoder: JSONDecoder
    
    init(jsonDecoder:JSONDecoder) {
        self._jsonDecoder = jsonDecoder
    }
    
    override func convert<T>(_ from: Data) throws -> T? where T : Decodable {
        return try _jsonDecoder.decode(T.self, from: from)
    }
}
