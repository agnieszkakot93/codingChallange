//
//  ShiftsViewModelTest.swift
//  CodingChallengeTests
//
//  Created by Agnieszka Kot on 12/01/2023.
//

@testable import CodingChallenge
import Combine
import XCTest

final class ShiftsViewModelTest: XCTestCase {

    private var mockService: MockService!
    private var sut: ShiftsViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockService()
        sut = ShiftsViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        mockService = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_whenViewDidLoad_thenShiftsArePopulated() {
        XCTAssertNil(sut.shiftsForCurrentDay?.shifts.count, "Starting with no data")

        let promise = self.expectation(description: "loading 1 shift")
        sut.fetchDataSubject.send(Date())

        sut.$shiftsForCurrentDay
            .sink { completion in
                XCTFail()
            } receiveValue: { shiftsData in
                if shiftsData?.shifts.count == 1 {
                    promise.fulfill()
                }
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 1)
    }

    func test_whenDataFetched_thenCorrectValuesMapped() {
        sut.fetchDataSubject.send(Date())
        let expectation = self.expectation(description: "text expectation")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        sut.$shiftsForCurrentDay
            .compactMap { $0 }
            .sink { shiftsForCurrentDay in
                XCTAssertEqual(shiftsForCurrentDay?.shifts.count, 1)
                XCTAssertTrue(((shiftsForCurrentDay?.shifts[0].premiumRate) != nil))
                XCTAssertEqual(shiftsForCurrentDay?.shifts[0].withinDistance, "100 mi")
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 0.3)
    }
}
