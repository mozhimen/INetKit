//
//  HEAD.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import SUtilKit_SwiftUI
import Foundation

extension Scope {
    @propertyWrapper
    public class HEAD<REQ>: PMethod {

        public let strPath: String
        public var method: Method { .HEAD }
        private var _customAction: IAsyncThrowA_BListener<REQ,Nothing?>?
        
        //==========================================>
        
        public init(_ strPath: String) {
            self.strPath = strPath
        }

        //==========================================>
        
        public static subscript<S: Scope>(
            _enclosingInstance scope: S,
            wrapped networkActionKeyPath: ReferenceWritableKeyPath<S, IAsyncThrowA_BListener<REQ,Nothing?>>,
            storage methodKeyPath: ReferenceWritableKeyPath<S, HEAD>
        ) -> IAsyncThrowA_BListener<REQ,Nothing?> {
            get {
                let method = scope[keyPath: methodKeyPath]
                return method._customAction ?? { try await scope.create(method: method,request: $0) }
            }
            set {
                let endpoint = scope[keyPath: methodKeyPath]
                endpoint._customAction = newValue
            }
        }

        @available(*, unavailable)
        public var wrappedValue: IAsyncThrowA_BListener<REQ,Nothing?> {
            get { fatalError("only works on instance properties of classes") }
            // swiftlint:disable:next unused_setter_value
            set { fatalError("only works on instance properties of classes") }
        }
    }
}
