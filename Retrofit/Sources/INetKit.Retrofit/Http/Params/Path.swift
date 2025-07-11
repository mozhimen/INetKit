//
//  Path.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
@propertyWrapper
public struct Path<T: CustomStringConvertible> {
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

extension Path: PRequestFactory {
    func parseRequestFields(forParameterWithName paramName: String, in builder: RequestBuilder.Builder) throws {
        let pathComponentName = customParamName ?? paramName
        let pathComponentValue = wrappedValue.description
        builder.addStrPathComponent(strPathComponent: "{\(pathComponentName)}", filledWith: pathComponentValue)
    }
}
