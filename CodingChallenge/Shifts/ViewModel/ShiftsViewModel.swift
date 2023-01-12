//
//  ShiftsViewModel.swift
//  CodingChallenge
//
//  Created by Agnieszka Kot on 06/01/2023.
//

import Foundation
import Combine

final class ShiftsViewModel: ObservableObject {

    @Published var currentDate: Date = Date()
    @Published var currentWeekViewData: [CurrentWeekViewData] = []
    @Published var shiftsForCurrentDay: ShiftsViewData?
    @Published var isModalPresenter: Bool = false
    @Published var modalViewData: ModalViewData?
    
    let selectedShiftViewData = PassthroughSubject<ShiftViewData, Never>()
    let fetchDataSubject = PassthroughSubject<Date, Never>()

    private let service: ServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published private var currentFetchedPage = 0
    @Published private var shiftsInitValue: [ShiftsViewData] = []

    init(service: ServiceProtocol) {
        self.service = service
        fetchCurrentWeek()
        getShifts()
        filterShiftsToShow()
        fetchSecondPage()
        createSelectedShiftDetails()
    }

    private func getShifts() {
        fetchDataSubject
            .removeDuplicates()
            .compactMap { startDate -> String? in
                return DateTimeFormatter.convertAPIDateToString(from: startDate)
            }
            .flatMap { startDate -> AnyPublisher<ShiftsResponse, Never> in
                self.service.request(from: .getAvaliableShifts(address: "Dallas, TX", type: .fourDay, start: startDate))
                    .catch { _ in Empty() }
                    .eraseToAnyPublisher()
            }
            .sink { print($0) } receiveValue: { [weak self] response in
                guard let self = self else { return }
                let shiftsList = self.mapShifts(response.data)
                self.shiftsInitValue.append(contentsOf: shiftsList)
                self.currentFetchedPage += 1
            }
            .store(in: &cancellables)
    }

    private func createSelectedShiftDetails() {
        selectedShiftViewData
            .map { details -> ModalViewData in
                return ModalViewData(title: details.facilityName,
                                     isPremiumPay: details.premiumRate,
                                     shiftType: details.shiftType,
                                     careType: details.careType,
                                     distance: details.withinDistance,
                                     price: "43")
            }
            .assign(to: &$modalViewData)
    }

    private func fetchSecondPage() {
        $currentFetchedPage
            .filter { $0 == 1 }
            .compactMap { _ -> Date? in
                return Calendar.current.date(byAdding: DateComponents(day: 4), to: Date())
            }
            .sink { [weak self] nextStartDate in
                self?.fetchDataSubject.send(nextStartDate)
            }
            .store(in: &cancellables)
    }

    private func mapShifts(_ response: [Data]) -> [ShiftsViewData] {
        return response.map { response -> ShiftsViewData in
            ShiftsViewData(date: response.date, shifts: response.shifts)
        }
    }

    private func fetchCurrentWeek() {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())
        (0...7 - weekday + 1).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: Date()) {
                currentWeekViewData.append(CurrentWeekViewData(date: weekday))
            }
        }
    }

    private func filterShiftsToShow() {
        $currentDate
            .combineLatest($shiftsInitValue)
            .map { [weak self] date, shifts -> ShiftsViewData? in
                let currentList = shifts.first(where: { shifts -> Bool in
                    return self?.isSameDayAndMonth(date1: shifts.date, date2: date) ?? false
                })
                return currentList
            }
            .assign(to: &$shiftsForCurrentDay)
    }

    func isSameDayAndMonth(date1: Date, date2: Date) -> Bool {
        let sameDay = Calendar.current.isDate(date1, equalTo: date2, toGranularity: .day)
        return sameDay
    }
}
