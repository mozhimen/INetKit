//
//  HttpTransport.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/7.
//
import Foundation

public protocol HttpTransport {
    func setConfiguration(scheme: String, host: String, sharedHeaders: [String: String]?)
    func sendRequest(with params: HttpRequestParams) async throws -> HttpOperationResult
}

