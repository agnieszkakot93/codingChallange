//
//  ShiftViewData.swift
//  CodingChallenge
//
//  Created by Agnieszka Kot on 11/01/2023.
//

import Foundation

struct ShiftViewData: Identifiable {

    var timeRange: String {
        [startTime, endTime].joined(separator: " - ")
    }

    let shiftId: Int
    let startTime: String
    let endTime: String
    let facilityName: String
    let withinDistance: String
    let premiumRate: Bool
    var id = UUID().uuidString
    let localizedSpecialty: String
    let shiftType: String
    let careType: String

    init(model: Shift) {
        shiftId = model.shiftID
        startTime = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let date = formatter.date(from: model.normalizedStartDateTime) else { return "" }
            return date.formatted(date: .omitted, time: .standard)
        }()
        endTime = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let date = formatter.date(from: model.normalizedEndDateTime) else { return "" }
            return date.formatted(date: .omitted, time: .standard)
        }()
        facilityName = model.facilityType.name.rawValue
        withinDistance = [String(model.withinDistance), "mi"].joined(separator: " ")
        premiumRate = model.premiumRate
        localizedSpecialty = model.localizedSpecialty.abbreviation.rawValue
        shiftType = model.shiftKind.rawValue
        careType = model.localizedSpecialty.specialty.name.rawValue
    }
}
