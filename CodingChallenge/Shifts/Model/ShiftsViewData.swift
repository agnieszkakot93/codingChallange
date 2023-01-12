//
//  ShiftsViewData.swift
//  CodingChallenge
//
//  Created by Agnieszka Kot on 10/01/2023.
//

import Foundation

struct ShiftsViewData: Identifiable {
    
    let shifts: [ShiftViewData]
    let id = UUID().uuidString
    let date: Date

    init(date: String, shifts: [Shift]) {
        self.date = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd"

            let date = dateFormatter.date(from: date) ?? Date()
            print(date)
            return date
        }()
        self.shifts = shifts.map { shift -> ShiftViewData in
            ShiftViewData(model: shift)
        }
    }
}
