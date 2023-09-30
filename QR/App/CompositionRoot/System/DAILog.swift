//
//  TextLog.swift
//
//
//  Created by Guillermo Moral on 03/08/2022.
//

import Foundation

class DAILog: TextOutputStream {

    var isDebug: Bool = false

    static var shared: DAILog = {
        let instance = DAILog()

        return instance
    }()

    private init() {}

    func write(_ string: String) {
        let localDate = Date().toUTC_yyyy_MM_dd_HH_mm_ss_ZZZ()
        if self.isDebug {
            print("\(localDate) \(string)")
        } else {
            let date_utc = Date().toUTC_yyyy_MM_dd()
            let fm = FileManager.default
            let log = fm.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Galicia_\(date_utc).log")

            let tmp = "\(localDate) | \(string)\n"
            print(log)
            if let handle = try? FileHandle(forWritingTo: log) {
                handle.seekToEndOfFile()
                handle.write(tmp.data(using: .utf8)!)
                handle.closeFile()
            } else {
                try? tmp.data(using: .utf8)?.write(to: log)
            }
        }
    }

    func cleanGGALLog() {
        let date_utc = Date().toUTC_yyyy_MM_dd()
        let fm = FileManager.default
        let fileUrl = fm.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("GaliciaL_\(date_utc).log")

        print(fileUrl)
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            do {
                try FileManager.default.removeItem(atPath: fileUrl.path)
            } catch {
                print("Could not delete file, probably read-only filesystem")
            }
        }
    }

    func readLog() -> String {
        let date_utc = Date().toUTC_yyyy_MM_dd()
        var result = ""

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("Galicia_\(date_utc).log")

            do {
                result = try String(contentsOf: fileURL, encoding: .utf8)
            } catch {
                result = ""
            }
        }

        return result
    }
}

enum DAIFormat: String {
    case yyyy_MM_dd = "yyyy-MM-dd"
    case yyyy_MM_dd_HH_mm_ss_ZZZ = "yyyy-MM-dd HH:mm:ss ZZZ"
    case yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss"
}

enum DAIAbbreviation: String {
    case UTC
    case Local
}

extension Date {
    func toUTC_yyyy_MM_dd() -> String {
        let daiDateFormatterFactory = DAIDateFormatterFactory()
        let formatter = daiDateFormatterFactory.createFormatterUTC_yyyy_MM_dd()
        let utcTimeZoneStr = formatter.string(from: self)
        return utcTimeZoneStr
    }

    func toUTC_yyyy_MM_dd_HH_mm_ss_ZZZ() -> String {
        let daiDateFormatterFactory = DAIDateFormatterFactory()
        let formatter = daiDateFormatterFactory.createFormatterUTC_yyyy_MM_dd_HH_mm_ss()
        let utcTimeZoneStr = formatter.string(from: self)
        return utcTimeZoneStr
    }

    func toLocal_yyyy_MM_dd_HH_mm_ss_ZZZ() -> String {
        let daiDateFormatterFactory = DAIDateFormatterFactory()
        let formatter = daiDateFormatterFactory.createFormatterLocal_yyyy_MM_dd_HH_mm_ss_ZZZ()
        let localTimeZoneStr = formatter.string(from: self)
        return localTimeZoneStr
    }
}
