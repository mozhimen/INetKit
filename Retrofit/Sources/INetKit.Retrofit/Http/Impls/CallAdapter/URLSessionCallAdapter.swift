//
//  AsyncCallAdapter.swift
//  INetKit.Retrofit
//
//  Created by Taiyou on 2025/7/11.
//
import Foundation
import SUtilKit_SwiftUI

class URLSessionCallAdapter:PCallAdapter{
    typealias REQ = Request
    typealias RES = Response
    
    ///=====================================================================>
    
    private var _strScheme: String
    private var _strHost: String
    private var _strHeadersGlobal: [String: String]?
    private var _intTimeoutIntervalForRequest:Double = 30
    private var _intTimeoutIntervalForResource:Double = 300
    
    private lazy var _uRLSession = URLSession(
        configuration: {
            let uRLSessionConfiguration = URLSessionConfiguration.default
            uRLSessionConfiguration.timeoutIntervalForRequest = _intTimeoutIntervalForRequest
            uRLSessionConfiguration.timeoutIntervalForResource = _intTimeoutIntervalForResource
            uRLSessionConfiguration.httpAdditionalHeaders = _strHeadersGlobal
            print("_uRLSession httpAdditionalHeaders \(uRLSessionConfiguration.httpAdditionalHeaders)")
            return uRLSessionConfiguration
        }()
    )
    
    ///=====================================================================>
    
    static func create(strScheme:String,strHost:String,strHeaders:[String:String]?,timeoutIntervalForRequest:Double,timeoutIntervalForResource:Double)->URLSessionCallAdapter{
        URLSessionCallAdapter.init(strScheme: strScheme, strHost: strHost, strHeaders: strHeaders, timeoutIntervalForRequest: timeoutIntervalForRequest, timeoutIntervalForResource: timeoutIntervalForResource)
    }
    
    ///=====================================================================>
    
    init(strScheme:String,strHost:String,strHeaders:[String:String]?,timeoutIntervalForRequest:Double,timeoutIntervalForResource:Double) {
        self._strScheme = strScheme
        self._strHost = strHost
        self._strHeadersGlobal = strHeaders
        self._intTimeoutIntervalForRequest = timeoutIntervalForRequest
        self._intTimeoutIntervalForResource = timeoutIntervalForResource
    }
    
    ///=====================================================================>

    func call(request: Request) async throws -> Response {
        do {
            let uRLRequest = try buildURLRequest(
                strMethod: request.method.method2strMethod(),
                strPath: request.strPath,
                body: request.body,
                strHeaders: request.strHeaders,
                strQuerys: request.strQuerys
            )
            return await dataTaskAsync(uRLRequest: uRLRequest)
        } catch {
            return Response.Error(error)
        }
    }
    
    ///=====================================================================>
    
    func buildURLRequest(
        strMethod: String,
        strPath: String,
        body: Data?,
        strHeaders: [String: String]?,
        strQuerys: [String: String]?
    ) throws -> URLRequest {
        var urlComponents = URLComponents()
        //
        urlComponents.scheme = _strScheme
        urlComponents.host = _strHost
        urlComponents.path = strPath
        urlComponents.queryItems = strQuerys?.map(URLQueryItem.init)
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        //
        var uRLRequest = URLRequest(url: url)
        uRLRequest.httpMethod = strMethod
        strHeaders?.forEach { key, value in
            uRLRequest.setValue(value, forHTTPHeaderField: key)
        }
        uRLRequest.httpBody = body
        //
        return uRLRequest
    }

    func dataTaskAsync(
        uRLRequest: URLRequest
    ) async -> Response {
        await withCheckedContinuation { [weak self] continuation in
            self?.dataTask(uRLRequest: uRLRequest, checkedContinuation: continuation)
                .resume()
        }
    }
    
    func dataTask(
        uRLRequest: URLRequest,
        checkedContinuation: CheckedContinuation<Response, Never>
    ) -> URLSessionDataTask {
        print(uRLRequest.uRLRequest2str())
        //
        return _uRLSession.dataTask(with: uRLRequest) { data, uRLResponse, error in
            print(uRLResponse?.uRLResponse2str(data: data, error: error))
            //
            let hTTPURLResponse = uRLResponse as? HTTPURLResponse
            let statusCode = hTTPURLResponse?.statusCode
            var headers: [String: String]?
            if let allHeaderFields = hTTPURLResponse?.allHeaderFields {
                headers = .init(minimumCapacity: allHeaderFields.count)
                allHeaderFields.forEach {
                    let key = String(describing: $0.key)
                    let value = String(describing: $0.value)
                    headers?[key] = value
                }
            }
            //
            let response:Response
            if let error {
                response = Response.Error(error)
            }else{
                if let data {
                    response = Response.Success(MResultIST(code: statusCode, msg: "", t:   data))
                }else{
                    response = Response.Empty
                }
            }
            checkedContinuation.resume(returning: response)
        }
    }
}
