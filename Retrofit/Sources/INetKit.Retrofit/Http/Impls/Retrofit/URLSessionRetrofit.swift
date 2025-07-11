//
//  Retrofit2URLSession.swift
//  URLSession
//
//  Created by Taiyou on 2025/7/11.
//
import Foundation
import SUtilKit_SwiftUI

class URLSessionRetrofit: Retroft {
    private var _strScheme: String?
    private var _strHost: String?
    private var _strHeadersGlobal: [String: String]?
    private var _intTimeoutIntervalForRequest:Double = 30
    private var _intTimeoutIntervalForResource:Double = 300

    private lazy var _uRLSession = URLSession(
        configuration: {
            let uRLSessionConfiguration = URLSessionConfiguration.default
            uRLSessionConfiguration.timeoutIntervalForRequest = _intTimeoutIntervalForRequest
            uRLSessionConfiguration.timeoutIntervalForResource = _intTimeoutIntervalForResource
            uRLSessionConfiguration.httpAdditionalHeaders = _strHeadersGlobal
            return uRLSessionConfiguration
        }()
    )
    
    ///=====================================================================>
    
    func setStrScheme(strScheme:String){
        self._strScheme = strScheme
    }
    
    func setStrHost(strHost:String){
        self._strHost = strHost
    }
    
    func setStrHeadersGlobal(strHeaders:[String:String]?){
        self._strHeadersGlobal = strHeaders
    }
    
    func setTimeoutIntervalForRequest(timeoutIntervalForRequest:Double){
        self._intTimeoutIntervalForRequest = timeoutIntervalForRequest
    }
    
    func setTimeoutIntervalForResource(timeoutIntervalForResource:Double){
        self._intTimeoutIntervalForResource = timeoutIntervalForResource
    }
    
    ///=====================================================================>
    
    func request(with requestBuilder: RequestBuilder) async throws -> ENetKRes {
        do {
            let uRLRequest = try buildURLRequest(
                strMethod: requestBuilder.method.method2strMethod(),
                strPath: requestBuilder.strPath,
                body: requestBuilder.body,
                strHeaders: requestBuilder.strHeaders,
                strQuerys: requestBuilder.strQuerys
            )
            return await dataTaskAsync(uRLRequest: uRLRequest)
        } catch {
            return ENetKRes.Error(error)
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
    ) async -> ENetKRes {
        await withCheckedContinuation { [weak self] continuation in
            self?.dataTask(uRLRequest: uRLRequest, checkedContinuation: continuation)
                .resume()
        }
    }
    
    func dataTask(
        uRLRequest: URLRequest,
        checkedContinuation: CheckedContinuation<ENetKRes, Never>
    ) -> URLSessionDataTask {
        print(uRLRequest.uRLRequest2str())
        //
        return _uRLSession.dataTask(with: uRLRequest) { data, uRLResponse, error in
            print(uRLResponse2str(uRLResponse: uRLResponse, data: data, error: error))
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
            let eNetKRes:ENetKRes
            if let error {
                eNetKRes = ENetKRes.Error(error)
            }else{
                if let data {
                    eNetKRes = ENetKRes.Success(MResultIST(code: statusCode, msg: "", t:   data))
                }else{
                    eNetKRes = ENetKRes.Empty
                }
            }
            checkedContinuation.resume(returning: eNetKRes)
        }
    }
}
