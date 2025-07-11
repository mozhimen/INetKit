//
//  AsyncCallAdapter.swift
//  INetKit.Retrofit
//
//  Created by Taiyou on 2025/7/11.
//

class URLSessionCallAdapter:PCallAdapter{
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
    
    
}
