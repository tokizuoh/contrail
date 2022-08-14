//
//  WorkoutCellTranslator.swift
//  contrail
//
//  Created by tokizo on 2022/08/14.
//

import HealthKit

struct WorkoutCellTranslator {
    typealias From = [HKWorkout]
    typealias To = [WorkoutAbstractViewItem]

    static private let format = "%.2f"

    static func translate(_ from: From) -> To {
        return from.map { workout in
            let distance = workout.totalDistance!.kilometers()
            let distanceText = String(format: format, distance)
            let dateText = workout.startDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)).replacingOccurrences(of: "/", with: ".")
            return .init(
                distanceText: distanceText,
                dateText: dateText
            )
        }
    }
}
