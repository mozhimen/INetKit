//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation

public extension Http{
    /// HTTP defines a set of request methods to indicate the desired action to be performed for a given resource. Although they can also be nouns, these request methods are sometimes referred to as HTTP verbs. Each of them implements a different semantic, but some common features are shared by a group of them
    /// HTTP 定义了一组用于指示针对特定资源应执行何种操作的请求方法。尽管这些请求方法也可以是名词，但有时它们也被称为 HTTP 动词。每个请求方法都具有不同的语义，但其中一些共同特征被一组请求方法所共用。
    enum Method: String, Hashable, CustomStringConvertible{
        ///The GET method requests a representation of the specified resource. Requests using GET should only retrieve data
        ///“GET”方法用于请求指定资源的呈现形式。使用“GET”方式进行的请求应当仅用于获取数据。
        case GET = "GET"
        
        ///The POST method submits an entity to the specified resource, often causing a change in state or side effects on the server
        ///POST 方法会将一个实体提交至指定的资源，通常会导致服务器状态的变化或产生副作用。
        case POST = "POST"
        
        ///The PUT method replaces all current representations of the target resource with the request payload
        ///
        case PUT = "PUT"
        
        ///The DELETE method deletes the specified resource
        ///
        case DELETE = "DELETE"
        
        ///The HEAD method asks for a response identical to a GET request, but without the response body
        ///
        case HEAD = "HEAD"
        
        ///The OPTIONS method describes the communication options for the target resource
        ///
        case OPTIONS = "OPTIONS"
        
        ///The PATCH method applies partial modifications to a resource
        ///
        case PATCH = "PATCH"
        
        //
        
        public var description:String{
            return self.rawValue
        }
    }
    
    enum ErrorInfo: Error{
        case status(Int?,URLResponse,Data?)
    }
    
    struct Configuration<R: PJsonReader, W: PJsonWriter>: PConfiguration, @unchecked Sendable{
        //Config
        
        ///BaseUrl
        public var baseURL:URL
        
        ///GEt Session
        ///@unchecked Sendable
        public var getSession: URLSession{
            session
        }
        
        ///Default content type is request body exist and there no content type header
        let defaultContentType:String = "application/json"
        
        ////Reader
        public let reader: R
        
        ///Writter
        public let writer: W
        
        //Private Properties
        
        ///An object that coordinates a group of related, network data transfer task
        ///@unchecked Sendable
        public let session: URLSession
        
        //Lifecycle
        
        /// - Parameters:
        ///   - reader: Reader
        ///   - writer: Writer
        ///   - baseURL: Base URL
        ///   - sessionConfiguration: A configuration object that defines behavior and policies for a URL session
        ///   - delegate: A protocol that defines methods that URL session instances call on their delegates to handle session-level events, like session life cycle changes
        ///   - queue: A queue that regulates the execution of operations
        
        public init(
            reader:R,
            writer:W,
            baseURL:URL,
            sessionConfiguration:URLSessionConfiguration,
            delegate:URLSessionDelegate? = nil,
            delegateQueue queue:OperationQueue? = nil
        ){
            self.reader = reader
            self.writer = writer
            self.baseURL = baseURL
            self.session = URLSession(configuration: sessionConfiguration, delegate: delegate, delegateQueue: queue)
        }
        
        /// - Parameters:
        ///   - reader: Reader
        ///   - writer: Writer
        ///   - baseURL: Base URL
        ///   - session: An object that coordinates a group of related, network data transfer tasks
        public init(
            reader: R,
            writer: W,
            baseURL:URL,
            session:URLSession
        ){
            self.reader = reader
            self.writer = writer
            self.baseURL = baseURL
            self.session = session
        }
    }
    
    //============================================================
    
    struct GET{
        /// Get request
        /// - Parameters:
        ///   - url: Url
        ///   - query: Query set
        ///   - headers: Additional headers
        ///   - retry: Amount of attempts is request is fail
        ///   - taskDelegate: URLSessionTaskDelegate
        /// - Returns: Data and URLResponse
        public static func from(
            _ url:URL,
            querys: Http.Querys? = nil,
            headers: Http.Headers? = nil,
            retry: UInt = 1,
            taskDelegate: PTaskDelegate? = nil
        ) async throws -> (Data,URLResponse){
            let request = try buildURLRequest(for: url,querys: querys,headers: headers)
            let strategy  = ServiceRetry.Strategy.exponential(retry: retry)
            return try await sendRetry(with: request, retry: strategy, taskDelegate)
        }
    }
    
    struct POST{
        /// Post request
        /// - Parameters:
        ///   - url: Url
        ///   - query: Query set
        ///   - headers: Additional headers
        ///   - retry: Amount of attempts is request is fail
        ///   - taskDelegate: URLSessionTaskDelegate
        /// - Returns: Data and URLResponse
        public static func from(
            _ url: URLRe
        )
    }
}
