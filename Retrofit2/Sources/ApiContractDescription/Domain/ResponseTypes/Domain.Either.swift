//
//  Domain.Either.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//

extension Domain {
    public enum Either<Response, ErrorResponse>: Decodable,Sendable where Response:Decodable ,Response:Sendable, ErrorResponse:Decodable,ErrorResponse:Sendable{
        case response(Response)
        case errorResponse(ErrorResponse)
    }
}

extension Domain.Either {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(Response.self) {
            self = .response(value)
        } else {
            let errorValue = try container.decode(ErrorResponse.self)
            self = .errorResponse(errorValue)
        }
    }
}
