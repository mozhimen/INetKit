//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation
import ISwiftKit

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
    
    //============================================================
    
    enum ErrorInfo: Error{
        case status(Int?,URLResponse,Data?)
    }
    
    //============================================================
    
    enum Validation{
        case status(StatusInfo)
    }
    
    //============================================================
    
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
    
    /// Http client for creating requests to the server
    /// Proxy does not keep any state It's just a transport layer to get and pass data
    struct Proxy<R:PJsonReader,W:PJsonWriter>: PProxy,@unchecked Sendable{
        /// An array of name-value pairs for a request
        public typealias Querys = [(String,String?)]
        
        ///A dictionary containing all of Http header fields for a request
        public typealias Headers = [String:String]
        
        ///Configuration
        public let config: Configuration<R,W>
        
        ///Http client for creating requests to the server
        ///- Parameter config: Configuration
        public init(config: Configuration<R, W>) {
            self.config = config
        }
        
        ///Get Request
        ///- Parameters
        ///-path:Path
        ///-querys: An array of name-value pairs
        ///-headers:A dictionary containing all of Http header fields for request
        ///-retry:Amount of attempts Default value .exponentials with 5 retry and duration 2,0
        ///-validate: Set of custom validate fun ``Http.Validate`` For status code like an example Default value to valigate statusCode == 200 Check out   ``Http.Validate.Status``
        ///-taskDelegate:A protocol that defines methods that URL Session instances call on their delegates to handle task-level events
        public func get<T>(
            path:String,
            querys:Http.Querys? = nil,
            headers:Http.Headers? = nil,
            retry: UInt = 5,
            validate: [Http.Validation] = [.status(200)],
            taskDelegate: PTaskDelegate?=nil
        )async throws -> Http.Response<T> where T:Decodable{
            let request = try buildURLRequest(config.baseURL, for: path,querys: querys,headers: headers)
            return try await send(with: request,use: strategy(retry),validate,taskDelegate)
        }
        
        ///Post Request
        ///- Parameters:
        ///- path: Path
        ///- querys: An array of name-value pairs
        ///- headers: A dictionary containing all of Http header fields for a request
        ///- retry: Amount of attempts Default value .expontial with 5 retry and duration 2,0
        ///- validate: Set of custom validate fun ``Http.Validation`` for status code like an example. Default value to validate statusCode == 200 check out ``Http.Validation.StatusInfo``
        ///- taskDelegate: A protocol that defines methods that URL session instances call on their delegates to handle task-level events
        public func post<T>(
            path:String,
            querys:Querys? = nil,
            headers:Headers? = nil,
            retry: UInt  = 5,
            validate: [Http.Validation] = [.status(200)],
            taskDelegate:PTaskDelegate? = nil
        )async throws -> Http.Response<T> where T:Decodable {
            let request = try buildURLRequest(config.baseURL, for: path,method: .POST, querys: querys,headers: headers)
            return try await send(with: request,use: strategy(retry),validate,taskDelegate)
        }
        
        ///Post  Request
        ///- Parameters:
        ///- path: Path
        ///- body: The data sent as the message body of a request, such as for an HTTP POST or PUT requests
        ///- querys: An array of name-value pairs
        ///- headers: A dictionary containing all of HTTP header fields for a request
        ///- retry: Amount of attempts Default value .expontial with  5 retry and dutation 2.0
        ///- validate: Set of custom validate fun ``Http.Validation`` For status code like an example Default value to validate statuscode == 200 check out ``Http.Validation.StatusInfo``
        ///- taskDelegate: A protocal that defines methods that URL session instances call on their delegates to handle task level events
        public func post<T,V:Encodable>(
            path:String,
            body:V,
            querys:Querys? = nil,
            headers:Headers? = nil,
            retry:UInt = 5,
            validate:[Http.Validation] = [.status(200)],
            taskDelegate:PTaskDelegate? = nil
        ) async throws -> Http.Response<T> where T:Decodable{
            let body = try config.writer.toJson(body)
            let request = try buildURLRequest(config.baseURL, for: path,method: .POST,body: body, querys: querys,headers: headers)
            return try await send(with: request,use: strategy(retry), validate, taskDelegate)
        }
        
        ///PUT request
        ///- parameters
        ///- path: Path
        ///- body: The data sent as the message body of a request, such as for an HTTP POST or PUT requests
        ///- querys: An array of name-value pairs
        ///- headers:A dictionary containing all of the HTTP header fields for a request
        ///- retry:Amount of attempts Default value .expontial with 5 retry and duration 2.0
        ///- validate: Set of custom validate fun ``Http.Validate`` for status code like an example Default value to validate statusCode == 200 You can set diff combinations check out ``Http.Validate.Status``
        ///- taskDelegate: A protocal that defines methods that url session instances call on their delegates to handle task-level events
        public func put<T,V:Encodable>(
            path:String,
            body:V,
            querys:Querys? = nil,
            headers:Headers? = nil,
            retry: UInt = 5,
            validate: [Http.Validation] = [.status(200)],
            taskDelegate: PTaskDelegate? = nil
        ) async throws -> Http.Response<T> where T:Decodable{
            let body = try config.writer.toJson(body)
            var request = try buildURLRequest(config.baseURL, for: path,method: .PUT,body: body,querys: querys,headers: headers)
            if hasNotContentType(config.getSession, request) {
                let content = config.defaultContentType
                request.setValue(content, forHTTPHeaderField: "Content-Type")
            }
            return try await send(with: request,use: strategy(retry),validate,taskDelegate)
        }
        
        ///Delete request
        ///- Parameters
        ///- path: Path
        ///- querys: An array of name-value pairs
        ///- headers: A dictionary containing all of the HTTP header fields for a request
        ///- retry: Amount of attempts Default value .expontenial with 5 retry and duration 2,0
        ///- validate:set of custom validate fun ``Http.Validation`` For status code like an example Default value to validate statusCode==200 You can set diff combinations check out ``Http.Validation.StatusInfo``
        ///- taskDelegate: A protocal that defines methods that URL session instances call on their delegates to handle task-level events
        public func delete<T>(
            path:String,
            querys:Querys? = nil,
            headers:Headers? = nil,
            retry: UInt = 5,
            validate: [Http.Validation] = [.status(200)],
            taskDelegate: PTaskDelegate? = nil
        ) async throws -> Http.Response<T> where T:Decodable {
            let request = try buildURLRequest(config.baseURL,for: path,method: .DELETE,querys: querys,headers: headers)
            return try await send(with: request,use: strategy(retry),validate,taskDelegate)
        }
        
        ///Send custom request based on the specific request instance
        ///- Parameters
        ///- request: A URL load request that is independent of protocol or URL scheme
        ///- retry ``ServiceKRetry.Strategy`` strategy Default value .exponential with 5 retry and duration 2,0
        ///- validate: Set of custom validate fun ``Http.Validate`` For status code like an example Default value to validate statusCode == 200 You can set up diff combinations check out ``Http.Validation.StatusInfo``
        ///- taskDelegate: A protocal that defines methods that URL session instances call on their delegates to handle task-level events
        public func send<T>(
            with request:URLRequest,
            use strategy: ServiceKRetry.Strategy = .exponential(),
            _ validate: [Http.Validation] = [.status(200)],
            _ taskDelegate: PTaskDelegate? = nil
        )async throws -> Http.Response<T> where T:Decodable{
            let reader = config.reader
            let (data,response) = try await sendRetry(with: request, use: strategy,taskDelegate,config.getSession)
            print("data: \(data)")
            try validateStatus(response, by: validate.pickStatusRules(),with: data)
            let value:T = try reader.fromJson(data: data)
            print("value: \(value)")
            return .init(value: value, data: data, response, request)
        }
    }
    
    //============================================================
    
    struct Response<T:Sendable>: PResponse,Sendable{
        ///Status Code
        public var statusCode:Int?{
            (urlResponse as? HTTPURLResponse)?.statusCode
        }
        
        //Mark: -Config
        ///Instance of a data
        public let value:T
        
        ///Raw data set
        public let data: Data
        
        ///Response
        public let urlResponse:URLResponse
        
        ///Resuqest
        public let urlRequest:URLRequest
        
        //mark: -Lifecircle
        
        ///The metadata associated with the response to a URL load request
        ///- Parameters
        ///- value: Instances of a data 
        ///- data: Raw data set
        ///- urlResponse: Response
        ///- urlRequest: Request
        init(
            value: T,
            data: Data,
            _ urlResponse: URLResponse,
            _ urlRequest: URLRequest
        ) {
            self.value = value
            self.data = data
            self.urlResponse = urlResponse
            self.urlRequest = urlRequest
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
            let strategy  = ServiceKRetry.Strategy.exponential(retry: retry)
            return try await sendRetry(with: request, use: strategy,taskDelegate)
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
            _ url: URL,
            body:Data? = nil,
            querys:Http.Querys? = nil,
            headers:Http.Headers? = nil,
            retry:UInt=1,
            taskDelegate:PTaskDelegate? = nil
        ) async throws -> (Data,URLResponse){
            let request = try buildURLRequest(for: url,method: .POST,body: body,querys: querys,headers: headers)
            let strategy = ServiceKRetry.Strategy.exponential(retry: retry)
            return try await sendRetry(with: request, use: strategy, taskDelegate)
        }
    }
    
    struct PUT{
        /// Put request
        /// - Parameters:
        ///   - url: Url
        ///   - query: Query set
        ///   - headers: Additional headers
        ///   - retry: Amount of attempts is request is fail
        ///   - taskDelegate: URLSessionTaskDelegate
        /// - Returns: Data and URLResponse
        public static func from(
            _ url:URL,
            body:Data? = nil,
            querys:Http.Querys? = nil,
            headers:Http.Headers? = nil,
            retry:UInt=1,
            taskDelegate:PTaskDelegate? = nil
        )async throws -> (Data,URLResponse){
            let request = try buildURLRequest(for: url,method:.PUT,body:body,querys:querys,headers:headers)
            let strategy = ServiceKRetry.Strategy.exponential(retry: retry)
            return try await sendRetry(with: request, use: strategy,taskDelegate)
        }
    }
    
    struct DELETE{
        /// Delete
        /// - Parameters:
        ///   - url: Url
        ///   - query: Query set
        ///   - headers: Additional headers
        ///   - retry: Amount of attempts is request is fail
        ///   - taskDelegate: URLSessionTaskDelegate
        /// - Returns: Data and URLResponse
        public static func from(
            _ url: URL,
            querys: Http.Querys? = nil,
            headers: Http.Headers? = nil,
            retry: UInt = 1,
            taskDelegate: PTaskDelegate? = nil
        ) async throws -> (Data,URLResponse){
            let request = try buildURLRequest(for: url,method: .DELETE,querys: querys,headers: headers)
            let strategy = ServiceKRetry.Strategy.exponential(retry: retry)
            return try await sendRetry(with: request, use: strategy,taskDelegate)
        }
    }
}

///
///Mark: File private
///
///Check presents of content type header
///- Parameters:
///- session: URLSession
///- request: URLRequest
///- Returns: true - content-type header is not empty
fileprivate func hasNotContentType(_ session: URLSession,_ request: URLRequest) -> Bool {
    request.value(forHTTPHeaderField: "Content-Type") == nil &&
    session.configuration.httpAdditionalHeaders?["Content-Type"] == nil
}

///Get default strategy for retries
fileprivate let strategy: @Sendable (UInt) -> ServiceKRetry.Strategy = { retry in
        .exponential(retry: retry)
}
