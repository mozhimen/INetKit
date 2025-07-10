//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation

/// Url builder method
/// - Parameters:
///   - url:  url
///   - query: An array of name-value pairs
/// - Returns: A value that identifies the location of a resource
internal func append(
    _ uRL: URL,
    with querys: Http.Querys? = nil
) throws -> URL{
    guard var components=URLComponents(url: uRL, resolvingAgainstBaseURL: true) else {
        throw URLError(.badURL)
    }
    
    if let querys, !querys.isEmpty {
        components.queryItems = querys.map(URLQueryItem.init)
    }
    
    guard let url = components.url else { throw URLError(.badURL) }
    
    return url
}

/// Url builder method
/// - Parameters:
///   - baseURL: Base url
///   - path: Path
///   - query: An array of name-value pairs
/// - Returns: A value that identifies the location of a resource
internal func buildURL(
    baseURL: URL,
    for path: String,
    querys: Http.Querys? = nil
) throws -> URL{
    guard let url = URL(string: path, relativeTo: baseURL) else {
        throw URLError(.badURL)
    }
    
    return try append(url,with: querys)
}


