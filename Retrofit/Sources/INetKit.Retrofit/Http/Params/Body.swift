//
//  Body.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//

import Foundation
@propertyWrapper
public struct Body<T: Encodable> {
    public let wrappedValue: T
    private let encoder: JSONEncoder

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.encoder = JSONEncoder()
    }
}

extension Body: PRequestFactory {
    func parseRequestFields(forParameterWithName paramName: String, in builder: Request.Builder, by retrofit: any PRetrofit) throws {
        guard let body = try retrofit.converterFactory.resquestBodyConverter()?.convert(wrappedValue) else {
            print("Body convert fail!")
            return
        }
        builder.setBody(body: body)
        builder.addStrHeaders(strHeaders:  ["Content-Type": "application/json"])
    }
}
