//
//  HttpRequestParams.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import Foundation
public struct HttpRequestParams {
    public let httpMethod: HttpMethod
    public let path: String
    public let headerParams: [String: String]?
    public let queryParams: [String: String]?
    public let body: Data?
}
