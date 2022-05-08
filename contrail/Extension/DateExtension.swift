//
//  DateExtension.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import Foundation

extension Date {
    enum StringFormat {
        case yyyyMMddPd
    }

    func string(format: StringFormat) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)

        switch format {
        case .yyyyMMddPd:
            formatter.dateFormat = "yyyy.MM.dd"
        }

        return formatter.string(from: self)
    }
}
