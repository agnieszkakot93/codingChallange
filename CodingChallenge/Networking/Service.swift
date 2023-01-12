//
//  AvaliableShiftsService.swift
//  CodingChallenge
//
//  Created by Agnieszka Kot on 07/01/2023.
//

import Foundation
import Combine

protocol ServiceProtocol {
    func request(from endpoint: Request) -> AnyPublisher<ShiftsResponse, CustomAPIError>
}

struct Service: ServiceProtocol {

    func request(from endpoint: Request) -> AnyPublisher<ShiftsResponse, CustomAPIError> {

        let jsonDecoder = JSONDecoder()

        guard let request = endpoint.urlRequest else {
            return Fail(error: .invalidEndpoint)
                .eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<ShiftsResponse, CustomAPIError> in

                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }

                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: ShiftsResponse.self, decoder: jsonDecoder)
                        .mapError { error in
                            let error = error as! DecodingError
                            print(error)
                            return .decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode))
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}

