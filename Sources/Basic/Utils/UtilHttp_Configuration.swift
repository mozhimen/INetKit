//
//  UtilHttp_Configuration.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/27.
//
import Foundation

public extension Http.Configuration where R == JsonReader, W == JsonWriter {
    /// Create configuration by base url
    /// URLSession is URLSession.shared
    ///  Reader and Writer for Json format
    /// - Parameter baseURL: Base url
    init(
        baseURL:URL
    ){
        self.reader = JsonReader()
        self.writer = JsonWriter()
        self.baseURL = baseURL
        self.session = URLSession.shared
    }
    
    /// - Parameters:
    ///   - baseURL: Base URL
    ///   - sessionConfiguration: A configuration object that defines behavior and policies for a URL session
    ///   - delegate: A protocol that defines methods that URL session instances call on their delegates to handle session-level events, like session life cycle changes
    ///   - queue: A queue that regulates the execution of operations
    init(
        baseURL:URL,
        sessionConfiguration:URLSessionConfiguration,
        delegate:URLSessionDelegate? = nil,
        delegateQueue queue: OperationQueue? = nil
    ) {
        self.reader = JsonReader()
        self.writer = JsonWriter()
        self.baseURL = baseURL
        self.session = URLSession(configuration: sessionConfiguration, delegate: delegate, delegateQueue: queue)
    }
}
