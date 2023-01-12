//
//  WeekDay.swift
//  CodingChallenge
//
//  Created by Agnieszka Kot on 11/01/2023.
//

import Foundation
import SwiftUI

struct CurrentWeekViewData: Identifiable {

    var stringDayName: String {
        date.formatted(.dateTime.weekday(.narrow))
    }

    var stringDayNumber: String {
        date.formatted(Date.FormatStyle().day(.twoDigits))
    }
    
    var id = UUID().uuidString
    var date: Date
}
