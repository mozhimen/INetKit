//
//  Domain.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import Foundation

open class Scope<R:PRetrofit> {
    private let _retrofit: R
    
    //===============================================>

    public init(retrofit: R) {
        self._retrofit = retrofit
    }

    //===============================================>
    
    open func create<REQ, RES: Decodable>(
        method: PMethod,
        request: REQ
    ) async throws -> RES {
        let request = try buildRequest(use: method, request: request)
        let response = try await _retrofit.callAdapterFactory.get(retrofit: _retrofit).adapt(call: _retrofit)
        switch response {
        case.Success(let data): {
            return try JSONDecoder.decode(RES,from: <#T##Data#>)
        }
        }
        if responseData.isEmpty, Response.self is Empty.Type {
            // swiftlint:disable:next force_cast
            return Empty() as! Response
        } else {
            return try JSONDecoder().decode(Response.self, from: responseData)
        }
    }
    
    //===============================================>
    
    private func buildRequest<REQ>(
        use method: PMethod,
        request: REQ
    ) throws ->RequestBuilder{
        //===========================================>
        let requestBuilder = RequestBuilder.Builder()
        //method
        requestBuilder.setMethod(method: method.method)
        //path
        requestBuilder.setStrPath(strPath: method.strPath)
        //others
        try Mirror(reflecting: request)
            .children
            .compactMap { child in
                guard let paramName = child.label,
                      let param = child.value as? PRequestFactory
                else { return nil }
                return (paramName, param)
            }
            .forEach { (paramName: String, builder: PRequestFactory) in
                try builder.parseRequestFields(forParameterWithName: paramName, in: requestBuilder, by: _retrofit)
            }
        return try requestBuilder.build()
    }
}
