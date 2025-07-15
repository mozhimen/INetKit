//
//  Header.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//

@propertyWrapper
public struct Header<T> where T:CustomStringConvertible {
    public let wrappedValue: T
    private let customParamName: String?

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.customParamName = nil
    }

    public init(wrappedValue: T, _ customName: String) {
        self.wrappedValue = wrappedValue
        self.customParamName = customName
    }
}

extension Header: PRequestFactory {
    func parseRequestFields(paramName: String, builder: Request.Builder, retrofit: any PRetrofit) throws {
        let headerParamName = customParamName ?? paramName
        let headerParamValue = wrappedValue.description
        builder.addStrHeaders(strHeaders: [headerParamName: headerParamValue])
    }
}
