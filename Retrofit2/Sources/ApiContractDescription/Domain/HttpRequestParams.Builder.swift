//
//  HttpRequestParams.Builder.swift.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import Foundation
extension HttpRequestParams {
    class Builder {
        enum BuilderError: Error {
            case httpMethodNotSet
            case pathNotSet
        }

        func buildRequestParams() throws -> HttpRequestParams {
            guard let httpMethod else { throw BuilderError.httpMethodNotSet }
            guard var path else { throw BuilderError.pathNotSet }

            pathComponentsValues?.forEach { pathComponent, value in
                path = path.replacingOccurrences(of: pathComponent, with: value)
            }

            return HttpRequestParams(
                httpMethod: httpMethod,
                path: path,
                headerParams: headerParams,
                queryParams: queryParams,
                body: body)
        }

        func set(httpMethod: HttpMethod) {
            self.httpMethod = httpMethod
        }

        func set(path: String) {
            self.path = path
        }

        func set(pathComponent: String, filledWith value: String) {
            if pathComponentsValues == nil {
                pathComponentsValues = [pathComponent: value]
            } else {
                pathComponentsValues?[pathComponent] = value
            }
        }

        func add(headerParams: [String: String]) {
            if self.headerParams == nil {
                self.headerParams = headerParams
            } else {
                self.headerParams?.merge(headerParams, uniquingKeysWith: { $1 })
            }
        }

        func add(queryParams: [String: String]) {
            if self.queryParams == nil {
                self.queryParams = queryParams
            } else {
                self.queryParams?.merge(queryParams, uniquingKeysWith: { $1 })
            }
        }

        func set(body: Data) {
            self.body = body
        }

        private var httpMethod: HttpMethod?
        private var path: String?
        private var pathComponentsValues: [String: String]?
        private var headerParams: [String: String]?
        private var queryParams: [String: String]?
        private var body: Data?
    }
}
