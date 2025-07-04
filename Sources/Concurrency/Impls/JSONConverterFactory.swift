//
//  JSONConverterFactory.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/4.
//
import Foundation

class JSONConverterFactory: PConverterFactory {
    private let jsonEncoder: JSONEncoder
    private let jsonDecoder: JSONDecoder
    
    static func create()->JSONConverterFactory{
        create(jsonEncoder: JSONEncoder(), jsonDecoder: JSONDecoder())
    }
    
    static func create(jsonEncoder:JSONEncoder,jsonDecoder:JSONDecoder)->JSONConverterFactory{
        JSONConverterFactory(jsonEncoder: jsonEncoder, jsonDecoder: jsonDecoder)
    }
    
    init(jsonEncoder:JSONEncoder,jsonDecoder:JSONDecoder) {
        self.jsonEncoder = jsonEncoder
        self.jsonDecoder = jsonDecoder
    }
    
    func resquestBodyConverter() -> PConverter<F, T, J> {
        return JSONEncoderRequestBodyConverter(convertor: jsonEncoder)
    }
    
    func responseBodyConverter() -> any PConverter<Data,Decodable,JSONDecoder> {
        return JSONDecoderResponseConverter(converter: jsonDecoder)
    }
}
