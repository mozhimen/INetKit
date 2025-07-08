//
//  RequestBuilder.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//

protocol PRequestFactory {
    func parseParameterFields(forParameterWithName paramName: String,in builder: HttpRequestParams.Builder) throws
}
