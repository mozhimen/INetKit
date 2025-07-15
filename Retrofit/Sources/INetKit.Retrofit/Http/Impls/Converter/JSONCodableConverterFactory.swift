//
//  JSONConverterFactory.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/4.
//
import Foundation

class JSONConverterFactory: PConverterFactory {
    private let _jsonEncoder: JSONEncoder
    private let _jsonDecoder: JSONDecoder
    
    //============================================
    
    static func create()->JSONConverterFactory{
        create(jsonEncoder: JSONEncoder(), jsonDecoder: JSONDecoder())
    }
    
    static func create(jsonEncoder: JSONEncoder, jsonDecoder: JSONDecoder)->JSONConverterFactory{
        JSONConverterFactory(jsonEncoder: jsonEncoder, jsonDecoder: jsonDecoder)
    }
    
    //============================================
    
    init(jsonEncoder:JSONEncoder, jsonDecoder:JSONDecoder) {
        self._jsonEncoder = jsonEncoder
        self._jsonDecoder = jsonDecoder
    }
    
    //============================================
    
    func resquestBodyConverter() -> PRequestConverter? {
        return JSONEncoderRequestBodyConverter(jsonEncoder: _jsonEncoder)
    }

    func responseBodyConverter() -> PResponseConverter? {
        return JSONDecoderResponseConverter(jsonDecoder: _jsonDecoder)
    }
}
