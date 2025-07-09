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
    func parseRequestFields(forParameterWithName paramName: String, in builder: RequestBuilder.Builder) throws {
        let body = try encoder.encode(wrappedValue)
        builder.setBody(body: body)
        builder.addHeaders(headers:  ["Content-Type": "application/json"])
    }
}
