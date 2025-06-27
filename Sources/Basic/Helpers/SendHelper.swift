//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation

/// - Parameters:
///   - request: A URL load request that is independent of protocol or URL scheme
///   - retry: ``RetryService`` strategy
///   - taskDelegate: A protocol that defines methods that URL session instances call on their delegates to handle task-level events
internal func sendRetry(
    with request: URLRequest,
    retry strategy:ServiceRetry.Strategy,
    _ taskDelegate: PTaskDelegate? = nil,
    _ urlSession: URLSession = .shared
) async throws -> (Data, URLResponse)
{
    let service = ServiceRetry(strategy: strategy)
    
    for delay in service.dropLast(){
        do{
            return try await urlSession.data(for: request,delegate: taskDelegate)
        }catch{
#if DEBUG
            print("retry send \(delay)")
#endif
        }
        
        try? await Task.sleep(nanoseconds: delay)
    }
    
    ///one more time to let the error to propagate if it fails the last time
    return try await urlSession.data(for: request, delegate: taskDelegate)
}
