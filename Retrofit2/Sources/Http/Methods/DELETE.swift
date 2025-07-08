//
//  DELETE.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//

extension Retrofit2Scope {
    @propertyWrapper
    public class DELETE<Request, Response: Decodable>: EndpointDescribing {
        public typealias NetworkAction = (Request) async throws -> Response

        public let path: String
        public var method: HttpMethod { .delete }

        public init(_ path: String) {
            self.path = path
        }

        public static subscript<EnclosingDomain: Domain>(
            _enclosingInstance domain: EnclosingDomain,
            wrapped networkActionKeyPath: ReferenceWritableKeyPath<EnclosingDomain, NetworkAction>,
            storage endpointKeyPath: ReferenceWritableKeyPath<EnclosingDomain, Delete>
        ) -> NetworkAction {
            get {
                let endpoint = domain[keyPath: endpointKeyPath]
                return endpoint.customAction ?? { try await domain.perform(request: $0, to: endpoint) }
            }
            set {
                let endpoint = domain[keyPath: endpointKeyPath]
                endpoint.customAction = newValue
            }
        }

        @available(*, unavailable)
        public var wrappedValue: NetworkAction {
            get { fatalError("only works on instance properties of classes") }
            // swiftlint:disable:next unused_setter_value
            set { fatalError("only works on instance properties of classes") }
        }

        private var customAction: NetworkAction?
    }
}
