//
//  Query.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//

@propertyWrapper
public struct Query<T: CustomStringConvertible> {
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

extension Query: PRequestFactory {
    func parseRequestFields(forParameterWithName paramName: String, in builder: Request.Builder, by retrofit: any PRetrofit) throws {
        let queryParamName = customParamName ?? paramName
        let queryParamValue = wrappedValue.description
        builder.addStrQuerys(strQuerys: [queryParamName: queryParamValue])
    }
}
