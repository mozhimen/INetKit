//
//  Domain.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import Foundation

open class Scope {
    private let _retrofit: Retrofit
    
    //===============================================>

    public init(retrofit: Retrofit) {
        self._retrofit = retrofit
    }

    //===============================================>
    
    open func perform<Request, Response: Decodable>(
        request: Request,
        use method: PMethod,
        customHeaders: [String: String]? = nil
    ) async throws -> Response {
        let requestBuilder = RequestBuilder.Builder()
        requestBuilder.setMethod(method: method.method)
        requestBuilder.setPath(path: method.path)

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

        if let customHeaders {
            requestBuilder.addHeaders(headers: customHeaders)
        }

        let requestParams = try requestBuilder.build()
        let operationResult = try await _retrofit.sendRequest(with: requestParams)
        let responseData = try operationResult.response.get()

        if responseData.isEmpty, Response.self is Empty.Type {
            // swiftlint:disable:next force_cast
            return Empty() as! Response
        } else {
            return try JSONDecoder().decode(Response.self, from: responseData)
        }
    }
}
