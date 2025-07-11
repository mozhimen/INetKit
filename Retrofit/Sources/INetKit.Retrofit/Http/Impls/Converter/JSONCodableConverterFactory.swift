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
    
    static func create(jsonEncoder:JSONEncoder,jsonDecoder:JSONDecoder)->JSONConverterFactory{
        JSONConverterFactory(jsonEncoder: jsonEncoder, jsonDecoder: jsonDecoder)
    }
    
    //============================================
    
    init(jsonEncoder:JSONEncoder,jsonDecoder:JSONDecoder) {
        self.jsonEncoder = jsonEncoder
        self.jsonDecoder = jsonDecoder
    }
    
    //============================================
    
    func resquestBodyConverter() -> (any PConverter<Any, any PRequestBody>)? {
        return JSONEncoderRequestBodyConverter(jsonEncoder: jsonEncoder)
    }
    
    func responseBodyConverter() -> (any PConverter<any PResponseBody, Any>)? {
        return JSONDecoderResponseConverter(jsonDecoder: jsonDecoder)
    }
}
