//
//  GET.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import SUtilKit_SwiftUI

extension Scope {
    @propertyWrapper
    public class GET<REQ, RES: Decodable>: PMethod {

        public let strPath: String
        public var method: Method { .GET }
        private var _customAction: IAsyncThrowA_BListener<REQ,RES?>?
        
        //==========================================>
        
        public init(_ strPath: String) {
            self.strPath = strPath
        }

        //==========================================>
        
        public static subscript<S: Scope>(
            _enclosingInstance scope: S,
            wrapped networkActionKeyPath: ReferenceWritableKeyPath<S, IAsyncThrowA_BListener<REQ,RES>>,
            storage methodKeyPath: ReferenceWritableKeyPath<S, GET>
        ) -> IAsyncThrowA_BListener<REQ,RES?> {
            get {
                let method = scope[keyPath: methodKeyPath]
                return method._customAction ?? { try await scope.create(method: method, request: $0) }
            }
            set {
                let endpoint = scope[keyPath: methodKeyPath]
                endpoint._customAction = newValue
            }
        }

        @available(*, unavailable)
        public var wrappedValue: IAsyncThrowA_BListener<REQ,RES> {
            get { fatalError("only works on instance properties of classes") }
            // swiftlint:disable:next unused_setter_value
            set { fatalError("only works on instance properties of classes") }
        }
    }
}
