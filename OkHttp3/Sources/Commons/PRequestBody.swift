//
//  PRequestBody.swift
//  INetKit
//
//  Created by Taiyou on 2025/7/7.
//
import Foundation

public protocol PRequestBody{
    var data:Data{get set}
}

public class RequestBody:PRequestBody{
    public var data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    static func create(data: Data)->PRequestBody{
        return RequestBody(data:data)
    }
}
