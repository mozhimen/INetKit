//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation

/// A URL load request builder method
/// - Parameters:
///   - baseURL: Base url
///   - path: Path
///   - method: The HTTP request method
///   - query: An array of name-value pairs
///   - body: The data sent as the message body of a request, such as for an HTTP POST or PUT requests
///   - headers: A dictionary containing all of the HTTP header fields for a request
/// - Returns: A URL load request
internal func buildURLRequest(
    _ baseURL: URL,
    for path: String,
    method: Http.Method = .GET,
    body: Data? = nil,
    querys: Http.Querys? = nil,
    headers: Http.Headers? = nil
) throws -> URLRequest{
    //url+query
    let url = try buildURL(baseURL: baseURL, for: path,querys: querys)
    
    //request
    var request = URLRequest(url: url)
    
    //headers
    if let headers{
        request.allHTTPHeaderFields = headers
    }
    
    //method
    request.httpMethod = method.rawValue
    
    //body
    if let body {
        request.httpBody = body
    }
    
    return request
}

/// A URL load request builder method
/// - Parameters:
///   - url: Base url
///   - method: The HTTP request method
///   - query: An array of name-value pairs
///   - body: The data sent as the message body of a request, such as for an HTTP POST or PUT requests
///   - headers: A dictionary containing all of the HTTP header fields for a request
/// - Returns: A URL load request
internal func buildURLRequest(
    for url: URL,
    method: Http.Method = .GET,
    body: Data? = nil,
    querys: Http.Querys? = nil,
    headers: Http.Headers? = nil
)throws -> URLRequest{
    //request
    var request = URLRequest(url: url)
    
    //headers
    if let headers {
        request.allHTTPHeaderFields = headers
    }
    
    //method
    request.httpMethod = method.rawValue
    
    //body
    if let body {
        request.httpBody = body
    }
    
    return request
}
