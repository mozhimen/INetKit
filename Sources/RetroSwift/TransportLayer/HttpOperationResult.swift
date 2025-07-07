//
//  HttpOperationResult.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/7.
//
import Foundation

public struct HttpOperationResult {
    let statusCode: Int?
    let headers: [String: String]?
    let response: Result<Data, Error>

    public init(statusCode: Int?, headers: [String: String]?, response: Result<Data, Error>) {
        self.statusCode = statusCode
        self.headers = headers
        self.response = response
    }
}
