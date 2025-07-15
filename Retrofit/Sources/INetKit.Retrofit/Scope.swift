//
//  Domain.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import Foundation
import SUtilKit_SwiftUI

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
    ) async throws -> RES? {
        let request:Request = try buildRequest(use: method, request: request)
        let response:Response = try await _retrofit.callAdapterFactory.get().call(request: request)
        switch response {
        case.Success(let data):
            print("response is Success")
            if RES.self is MResultIST<RES>.Type {
                return response as! RES
            }
            guard let t = data.t else {
                return nil
            }
            return try _retrofit.converterFactory.responseBodyConverter()!.convert(t)
        case.Empty:
            print("response is Empty")
            return nil
        case.Error(let error):
            print("response is Error \(error)")
            return nil
        }
    }
    
    //===============================================>
    
    private func buildRequest<REQ>(
        use method: PMethod,
        request: REQ
    ) throws -> Request{
        //===========================================>
        let builder = Request.Builder()
        //method
        builder.setMethod(method: method.method)
        //path
        builder.setStrPath(strPath: method.strPath)
        //others
        try Mirror(reflecting: request)
            .children
            .compactMap { child in
                guard let paramName = child.label,
                      let param = child.value as? PRequestFactory
                else { return nil }
                return (paramName, param)
            }
            .forEach { (paramName: String, factory: PRequestFactory) in
                try factory.parseRequestFields(paramName: paramName, builder: builder, retrofit: _retrofit)
            }
        return try builder.build()
    }
}
