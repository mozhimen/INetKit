//
//  HttpRequestParams.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import Foundation
public struct RequestBuilder {
    public let method: Method
    public let path: String
    public let headers: [String: String]?
    public let querys: [String: String]?
    public let body: Data?
}

extension RequestBuilder {
    class Builder {
        enum BuilderError: Error {
            case HttpMethod_NotSet
            case Path_NotSet
        }
        
        //======================================================>
        
        private var _method: Method?
        private var _path: String?
        private var _pathComponents: [String: String]?
        private var _headers: [String: String]?
        private var _querys: [String: String]?
        private var _body: Data?

        //======================================================>
        
        func build() throws -> RequestBuilder {
            guard let method = _method else { throw BuilderError.HttpMethod_NotSet }
            guard var path = _path else { throw BuilderError.Path_NotSet }

            _pathComponents?.forEach { pathComponent, value in
                path = path.replacingOccurrences(of: pathComponent, with: value)
            }

            return RequestBuilder(
                method: method,
                path: path,
                headers: _headers,
                querys: _querys,
                body: _body)
        }

        //======================================================>
        
        func setMethod(method: Method) {
            self._method = method
        }

        func setPath(path: String) {
            self._path = path
        }
        
        func setBody(body: Data) {
            self._body = body
        }

        func addPathComponent(pathComponent: String, filledWith value: String) {
            if self._pathComponents == nil {
                self._pathComponents = [pathComponent: value]
            } else {
                self._pathComponents?[pathComponent] = value
            }
        }

        func addHeaders(headers: [String: String]) {
            if self._headers == nil {
                self._headers = headers
            } else {
                self._headers?.merge(headers, uniquingKeysWith: { $1 })
            }
        }

        func addQuerys(querys: [String: String]) {
            if self._querys == nil {
                self._querys = querys
            } else {
                self._querys?.merge(querys, uniquingKeysWith: { $1 })
            }
        }
    }
}
