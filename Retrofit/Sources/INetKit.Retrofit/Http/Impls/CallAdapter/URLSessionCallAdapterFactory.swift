//
//  AsyncCallAdapter.swift
//  INetKit.Retrofit
//
//  Created by Taiyou on 2025/7/11.
//

class URLSessionCallAdapterFactory: PCallAdapterFactory{
    private var _strScheme: String
    private var _strHost: String
    private var _strHeadersGlobal: [String: String]?
    private var _intTimeoutIntervalForRequest:Double = 30
    private var _intTimeoutIntervalForResource:Double = 300
    
    //============================================
    
    static func create(strScheme: String, strHost: String, strHeadersGlobal: [String : String]? = nil, intTimeoutIntervalForRequest: Double, intTimeoutIntervalForResource: Double)->URLSessionCallAdapterFactory{
        URLSessionCallAdapterFactory(strScheme: strScheme, strHost: strHost, intTimeoutIntervalForRequest: intTimeoutIntervalForRequest, intTimeoutIntervalForResource: intTimeoutIntervalForResource)
    }
    
    //============================================
    
    init(strScheme: String, strHost: String, strHeadersGlobal: [String : String]? = nil, intTimeoutIntervalForRequest: Double, intTimeoutIntervalForResource: Double) {
        self._strScheme = strScheme
        self._strHost = strHost
        self._strHeadersGlobal = strHeadersGlobal
        self._intTimeoutIntervalForRequest = intTimeoutIntervalForRequest
        self._intTimeoutIntervalForResource = intTimeoutIntervalForResource
    }
    
    //============================================
    
    func get() -> (any PCallAdapter<Request,Response>) {
        return URLSessionCallAdapter(strScheme: _strScheme, strHost: _strHost, strHeaders: _strHeadersGlobal, timeoutIntervalForRequest: _intTimeoutIntervalForRequest, timeoutIntervalForResource: _intTimeoutIntervalForResource)
    }
}

