//
//  CustomAPIError.swift
//  CodingChallenge
//
//  Created by Agnieszka Kot on 08/01/2023.
//

import Foundation

enum CustomAPIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
    case invalidEndpoint
}

extension CustomAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return "DecodingFailed"
        case .errorCode(let code):
            return "\(code) - code"
        case .unknown:
            return "Unknown"
        case .invalidEndpoint:
            return "Invalid Endpoint"
        }
    }
}
