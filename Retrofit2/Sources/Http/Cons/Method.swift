//
//  HttpMethod.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//

public enum Method {
    case DELETE
    case GET
    case HEAD
    case PATCH
    case POST
    case PUT
}

public extension Method {
    func method2strMethod(): String {
        switch self {
        case .DELETE: return "DELETE"
        case .GET: return "GET"
        case .HEAD: return "HEAD"
        case .PATCH: return "PATCH"
        case .POST: return "POST"
        case .PUT: return "PUT"
        }
    }
}
