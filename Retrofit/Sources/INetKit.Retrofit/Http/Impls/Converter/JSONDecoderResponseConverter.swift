//
//  JSONEncoderResponseConverter.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/4.
//
import Foundation

class JSONDecoderResponseConverter : PConverter{
    typealias F = PResponseBody
    typealias T = Any
    private let _jsonDecoder: JSONDecoder
    
    init(jsonDecoder:JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func convert(_ from: PResponseBody) throws -> T {
        guard let data = from.data else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: [],
                    debugDescription: "响应体没有数据"
                )
            )
        }
        
        // 如果 T 是 Data，直接返回
        if T.self == Data.self {
            return data
        }
        
        // 如果 T 是 String，尝试解码成字符串
        if T.self == String.self {
            guard let string = String(data: data, encoding: .utf8) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: [],
                        debugDescription: "无法解码成 UTF-8 字符串"
                    )
                )
            }
            return string
        }
        
        // 如果 T 是 Decodable 类型，尝试解码
        guard let decodableType = T.self as? Decodable.Type else {
            throw DecodingError.typeMismatch(
                T.self,
                DecodingError.Context(
                    codingPath: [],
                    debugDescription: "目标类型 \(T.self) 不符合 Decodable 协议"
                )
            )
        }
        
        return try jsonDecoder.decode(decodableType, from: data)
    }
}
