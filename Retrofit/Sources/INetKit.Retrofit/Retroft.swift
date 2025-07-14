//
//  Retroft.swift
//  INetKit.Retrofit
//
//  Created by Taiyou on 2025/7/11.
//

open class Retroft:PRetrofit{
    private var _strScheme: String = "https"
    private var _strHost: String = "localhost:8080"
    private var _strHeadersGlobal: [String: String]? = nil
    private var _intTimeoutIntervalForRequest:Double = 30
    private var _intTimeoutIntervalForResource:Double = 300
    
    ///=====================================================================>
    
    init(strScheme: String, strHost: String, strHeadersGlobal: [String : String]? = nil, intTimeoutIntervalForRequest: Double = 30, intTimeoutIntervalForResource: Double = 300) {
        self._strScheme = strScheme
        self._strHost = strHost
        self._strHeadersGlobal = strHeadersGlobal
        self._intTimeoutIntervalForRequest =  intTimeoutIntervalForRequest
        self._intTimeoutIntervalForResource = intTimeoutIntervalForResource
    }
    
    ///=====================================================================>
    
    public lazy var callAdapterFactory: any PCallAdapterFactory = URLSessionCallAdapterFactory.create(strScheme: _strScheme, strHost: _strHost, strHeadersGlobal: _strHeadersGlobal, intTimeoutIntervalForRequest: _intTimeoutIntervalForRequest, intTimeoutIntervalForResource: _intTimeoutIntervalForResource)
    public lazy var converterFactory: any PConverterFactory = JSONConverterFactory.create()
    
    public func setConverterFactory(converterFactory: any PConverterFactory) {
        self.converterFactory = converterFactory
    }
    
    public func setCallAdapterFactory(callAdapterFactory: any PCallAdapterFactory) {
        self.callAdapterFactory = callAdapterFactory
    }
}

public extension Retroft{
    public class Builder{
        private var _strScheme: String = "https"
        private var _strHost: String = "localhost:8080"
        private var _strHeadersGlobal: [String: String]?
        private var _intTimeoutIntervalForRequest:Double = 30
        private var _intTimeoutIntervalForResource:Double = 300
        
        public init(){}
        
        public func setStrScheme(_ strScheme:String)->Builder{
            self._strScheme = strScheme
            return self
        }
        
        public func setStrHost(_ strHost:String)->Builder{
            self._strHost = strHost
            return self
        }
        
        public func setStrHeadersGlobal(_ strHeaders:[String:String]?)->Builder{
            self._strHeadersGlobal = strHeaders
            return self
        }
        
        public func setTimeoutIntervalForRequest(_ timeoutIntervalForRequest:Double)->Builder{
            self._intTimeoutIntervalForRequest = timeoutIntervalForRequest
            return self
        }
        
        public func setTimeoutIntervalForResource(_ timeoutIntervalForResource:Double)->Builder{
            self._intTimeoutIntervalForResource = timeoutIntervalForResource
            return self
        }
        
        public func build()->Retroft{
            return Retroft(strScheme: _strScheme, strHost: _strHost,strHeadersGlobal: _strHeadersGlobal,intTimeoutIntervalForRequest: _intTimeoutIntervalForRequest,intTimeoutIntervalForResource: _intTimeoutIntervalForResource)
        }
    }
}
