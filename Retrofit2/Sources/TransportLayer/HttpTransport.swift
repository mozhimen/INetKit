//
//  HttpTransport.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//

public protocol HttpTransport {
    func setConfiguration(scheme: String, host: String, sharedHeaders: [String: String]?)
    func sendRequest(with params: HttpRequestParams) async throws -> HttpOperationResult
}
