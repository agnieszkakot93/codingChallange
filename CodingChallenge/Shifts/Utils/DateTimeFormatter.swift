//
//  DateTimeFormatter.swift
//  CodingChallenge
//
//  Created by Agnieszka Kot on 10/01/2023.
//

import Foundation

class DateTimeFormatter {

    private static let dateOnlyFormatter: DateFormatter = {
        let apiDateFormatter = DateFormatter()
        apiDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        apiDateFormatter.dateFormat = "yyyy-MM-dd"
        return apiDateFormatter
    }()

    static func convertAPIDateToString(from value: Date) -> String {
        return DateTimeFormatter.dateOnlyFormatter.string(from: value)
    }
}
