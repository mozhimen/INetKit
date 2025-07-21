//
//  Scope.ENetKRes.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/9.
//
import Foundation
import SUtilKit_SwiftUI

public enum Response{
//    case Uninitialzed
//    case Loading
    case Empty
    case Success(MResultIST<Data>)
    case Error(Error)
}

public struct Nothing: Decodable { }
public struct EmptyBody:Encodable{
    
    public init() {}
}

public enum ResponseOptional<S:Decodable,E:Decodable>:Decodable{
    case success(S)
    case error(E)
}

public extension ResponseOptional{
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let s = try? container.decode(S.self) {
            self = .success(s)
        } else {
            let e = try container.decode(E.self)
            self = .error(e)
        }
    }
}
