//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/30.
//

import Foundation


public extension Http.Validation{
    ///Set of validate cases for Response status code
    enum StatusInfo:PValidator{
        public typealias Predicate = (Int) -> Bool
        public typealias ErrorBlock = @Sendable (Int,URLResponse,Data?) -> Error?
        
        ///Validate by exact value
        case const(Int = 200)
        ///validate by range
        case range(Range<Int> = 200..<300)
        ///Validate by predicate func if you need some specific logic
        case predicate(Predicate)
        ///Check status and custom error if status is not valid
        case check(ErrorBlock)
    }
    
    var pickStatusRule:StatusInfo{
        switch(self){
        case.status(let rule):return rule
        }
    }
}

internal extension Collection where Element == Http.Validation{
    ///Pick up rules for validating HTTPURLResponse.statusCode
    ///- Returns: Collection of rules for validating statusCode
    func pickStatusRules() -> [Http.Validation.StatusInfo] {
        map{ $0.pickStatusRule }
    }
}
