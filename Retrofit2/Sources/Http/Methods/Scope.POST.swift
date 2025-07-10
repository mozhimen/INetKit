//
//  POST.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//
import SUtilKit

extension Scope {
    @propertyWrapper
    public class POST<REQ, RES: Decodable>: PMethod {
        public let path: String
        public var method: Method { .POST }
        private var _customAction: IAsyncThrowA_BListener<REQ,RES>?
        
        //==========================================>
        
        public init(_ path: String) {
            self.path = path
        }

        //==========================================>
        
        public static subscript<S: Scope>(
            _enclosingInstance scope: S,
            wrapped networkActionKeyPath: ReferenceWritableKeyPath<S, IAsyncThrowA_BListener<REQ,RES>>,
            storage methodKeyPath: ReferenceWritableKeyPath<S, POST>
        ) -> IAsyncThrowA_BListener<REQ,RES> {
            get {
                let method = scope[keyPath: methodKeyPath]
                return method._customAction ?? { try await scope.create(use: method,request: $0) }
            }
            set {
                let method = scope[keyPath: methodKeyPath]
                method._customAction = newValue
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
