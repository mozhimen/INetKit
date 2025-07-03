//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/30.
//

import Foundation

///A type that can be initiaized with an integer literal
extension Http.Validation.StatusInfo:ExpressibleByIntegerLiteral{
    ///Creates an instance initialized to specified integer value.
    public init(integerLiteral value:Int) {
        self = .const(value)
    }
    
    ///Validate status
    ///-Parameters
    ///-response: URLResponse
    ///-data: Received data
    func validate(_ response: URLResponse, with data: Data?) throws {
        guard let status = (response as? HTTPURLResponse)?.statusCode else {
//            return try err(nil, response: response, with: data)
            return try err(nil, response, with: data)
        }
        
        switch(self){
        case .const(let value):
            if value != status { try err(status, response,with: data) }
        case.range(let value):
            if !value.contains(status) { try err(status, response, with: data) }
        case.predicate(let fn):
            if !fn(status) { try err(status, response, with: data) }
        case.check(let checkFn):
            if let error = checkFn(status,response,data){
                throw error
            }
        }
    }
}

//Mark: - Public functional

///Validate status
///- Parameters
///- response: URLResponse
///- rules: A rule for validating ``Http.Validation.StatusInfo``
///- data: Received data
///- Throws: ``Http.ErrorInfo.status``
public func validateStatus(
    _ response: URLResponse,
    by rule: Http.Validation.StatusInfo,
    with data:Data? = nil
)throws{
    try rule.validate(response, with: data)
}

///Validate status
///- Parameters
///- response: URLResponse
///- rules: rules for validating  ``Http.Validate.Status``
///- data: Received data
///- Throws: ``Http.ErrorInfo.status``
public func validateStatus(
    _ response: URLResponse,
    by rules: [Http.Validation.StatusInfo],
    with data: Data? = nil
)throws {
    try rules.forEach({
        try validateStatus(response, by: $0, with: data)
    })
}

//============================================================>

//Mark: - File private
fileprivate func err(
    _ status:Int?, _ response: URLResponse,
    with data:Data?
)throws{
    throw Http.ErrorInfo.status(status, response, data)
}
