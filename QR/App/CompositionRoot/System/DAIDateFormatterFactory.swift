//
//  DAIDateFormatterFactory.swift
//
//
//  Created by Guillermo Moral on 05/08/2022.
//

import Foundation

protocol DateFormatterFactory {
    func createFormatterUTC_yyyy_MM_dd() -> DateFormatter
    func createFormatterUTC_yyyy_MM_dd_HH_mm_ss_ZZZ() -> DateFormatter
    func createFormatterLocal_yyyy_MM_dd_HH_mm_ss_ZZZ() -> DateFormatter
}

class DAIDateFormatterFactory: DateFormatterFactory {
    func createFormatterUTC_yyyy_MM_dd() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DAIFormat.yyyy_MM_dd.rawValue
        formatter.timeZone = NSTimeZone(abbreviation: DAIAbbreviation.UTC.rawValue) as TimeZone?

        return formatter
    }

    func createFormatterUTC_yyyy_MM_dd_HH_mm_ss_ZZZ() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DAIFormat.yyyy_MM_dd_HH_mm_ss_ZZZ.rawValue
        formatter.timeZone = NSTimeZone(abbreviation: DAIAbbreviation.UTC.rawValue) as TimeZone?

        return formatter
    }

    func createFormatterUTC_yyyy_MM_dd_HH_mm_ss() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DAIFormat.yyyy_MM_dd_HH_mm_ss.rawValue
        formatter.timeZone = NSTimeZone(abbreviation: DAIAbbreviation.UTC.rawValue) as TimeZone?

        return formatter
    }

    func createFormatterLocal_yyyy_MM_dd_HH_mm_ss_ZZZ() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DAIFormat.yyyy_MM_dd_HH_mm_ss_ZZZ.rawValue
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current

        return formatter
    }
}
