//
//  HEAD.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import SUtilKit
import Foundation

extension Scope {
    @propertyWrapper
    public class HEAD<REQ>: PMethod {

        public let path: String
        public var method: Method { .HEAD }
        private var _customAction: IAsyncThrowA_BListener<REQ,Empty>?
        
        //==========================================>
        
        public init(_ path: String) {
            self.path = path
        }

        //==========================================>
        
        public static subscript<S: Scope>(
            _enclosingInstance scope: S,
            wrapped networkActionKeyPath: ReferenceWritableKeyPath<S, IAsyncThrowA_BListener<REQ,Empty>>,
            storage methodKeyPath: ReferenceWritableKeyPath<S, HEAD>
        ) -> IAsyncThrowA_BListener<REQ,Empty> {
            get {
                let method = scope[keyPath: methodKeyPath]
                return method._customAction ?? { try await scope.create(use: method,request: $0) }
            }
            set {
                let endpoint = scope[keyPath: methodKeyPath]
                endpoint._customAction = newValue
            }
        }

        @available(*, unavailable)
        public var wrappedValue: IAsyncThrowA_BListener<REQ,Empty> {
            get { fatalError("only works on instance properties of classes") }
            // swiftlint:disable:next unused_setter_value
            set { fatalError("only works on instance properties of classes") }
        }
    }
}
