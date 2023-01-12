//
//  DateTimeFormatterTests.swift
//  CodingChallengeTests
//
//  Created by Agnieszka Kot on 12/01/2023.
//

@testable import CodingChallenge
import Combine
import XCTest

class MockService: ServiceProtocol {

    var expectedResponse: ShiftsResponse = .fixture()
    var expecterErrorType: CustomAPIError = .errorCode(400)
    var success: Bool = true

    func request(from endpoint: Request) -> AnyPublisher<ShiftsResponse, CustomAPIError> {
        guard success else {
            return Fail(error: expecterErrorType)
                .delay(for: .seconds(0.2), scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        }
        return Just(expectedResponse)
            .setFailureType(to: CustomAPIError.self)
            .delay(for: .seconds(0.2), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
