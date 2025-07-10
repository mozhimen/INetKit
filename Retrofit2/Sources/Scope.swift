//
//  Domain.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import Foundation

open class Scope {
    private let _retrofit: PRetrofit
    
    //===============================================>

    public init(retrofit: PRetrofit) {
        self._retrofit = retrofit
    }

    //===============================================>
    
    open func create<REQ, RES: Decodable>(
        use method: PMethod,
        request: REQ
//        customHeaders: [String: String]? = nil
    ) async throws -> RES {
        let requestParams = try buildRequest(use: method, request: request)
        let eNetKRes = try await _retrofit.request(with: requestParams)
        let responseData = try operationResult.response.get()

        if responseData.isEmpty, Response.self is Empty.Type {
            // swiftlint:disable:next force_cast
            return Empty() as! Response
        } else {
            return try JSONDecoder().decode(Response.self, from: responseData)
        }
    }
    
    private func buildRequest<REQ>(
        use method: PMethod,
        request: REQ
    ) throws ->RequestBuilder{
        //===========================================>
        let requestBuilder = RequestBuilder.Builder()
        //method
        requestBuilder.setMethod(method: method.method)
        //path
        requestBuilder.setPath(path: method.path)
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
                try builder.parseRequestFields(forParameterWithName: paramName, in: requestBuilder)
            }
        //headers
//        if let customHeaders {
//            requestBuilder.addHeaders(headers: customHeaders)
//        }
        return try requestBuilder.build()
    }
}
