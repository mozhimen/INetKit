//
//  HttpTransport.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//

public protocol Retrofit {
    func setConfiguration(scheme: String, host: String, sharedHeaders: [String: String]?)
    func sendRequest(with requestBuilder: RequestBuilder) async throws -> MResultIST<>
}

/**
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
 */
