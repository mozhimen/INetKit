//
//  HttpRequestParams.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import Foundation
public struct Request {
    public let method: Method
    public let strPath: String
    public let strHeaders: [String: String]?
    public let strQuerys: [String: String]?
    public let body: Data?
}

extension Request {
    class Builder {
        enum BuilderError: Error {
            case HttpMethod_NotSet
            case Path_NotSet
        }
        
        //======================================================>
        
        private var _method: Method?
        private var _strPath: String?
        private var _strPathComponents: [String: String]?
        private var _strHeaders: [String: String]?
        private var _strQuerys: [String: String]?
        private var _body: Data?

        //======================================================>
        
        func build() throws -> RequestBuilder {
            guard let method = _method else { throw BuilderError.HttpMethod_NotSet }
            guard var strPath = _strPath else { throw BuilderError.Path_NotSet }

            _strPathComponents?.forEach { pathComponent, value in
                strPath = strPath.replacingOccurrences(of: pathComponent, with: value)
            }

            return RequestBuilder(
                method: method,
                strPath: strPath,
                strHeaders: _strHeaders,
                strQuerys: _strQuerys,
                body: _body)
        }

        //======================================================>
        
        func setMethod(method: Method) {
            self._method = method
        }

        func setStrPath(strPath: String) {
            self._strPath = strPath
        }
        
        func setBody(body: Data) {
            self._body = body
        }

        func addStrPathComponent(strPathComponent: String, filledWith value: String) {
            if self._strPathComponents == nil {
                self._strPathComponents = [strPathComponent: value]
            } else {
                self._strPathComponents?[strPathComponent] = value
            }
        }

        func addStrHeaders(strHeaders: [String: String]) {
            if self._strHeaders == nil {
                self._strHeaders = strHeaders
            } else {
                self._strHeaders?.merge(strHeaders, uniquingKeysWith: { $1 })
            }
        }

        func addStrQuerys(strQuerys: [String: String]) {
            if self._strQuerys == nil {
                self._strQuerys = strQuerys
            } else {
                self._strQuerys?.merge(strQuerys, uniquingKeysWith: { $1 })
            }
        }
    }
}
