//
//  Request.swift
//  CodingChallenge
//
//  Created by Agnieszka Kot on 08/01/2023.
//

import Foundation

protocol RequestBuilder {
    var urlRequest: URLRequest? { get }
}

enum Request {
    case getAvaliableShifts(address: String, type: ShiftListType, start: String)
}

extension Request: RequestBuilder {

    var urlRequest: URLRequest? {
        switch self {
        case let .getAvaliableShifts(address, type, start):
            let queryItems = [URLQueryItem(name: "address", value: address),
                              URLQueryItem(name: "type", value: type.rawValue),
            URLQueryItem(name: "start", value: start)]
            return buildRequest(endpoint: "/available_shifts", queryItems: queryItems)
        }
    }

    private func buildRequest(endpoint: String,
                              queryItems: [URLQueryItem]) -> URLRequest? {
        var urlComps = URLComponents(string: "https://staging-app.shiftkey.com/api/v2/available_shifts")!
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else {
            return nil
        }

        let request = URLRequest(url: url)
        return request
    }
}
