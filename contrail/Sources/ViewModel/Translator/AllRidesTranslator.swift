//
//  AllRidesTranslator.swift
//  contrail
//
//  Created by tokizo on 2022/05/15.
//

import HealthKit

struct AllRidesTranslator {
    typealias From = [HKWorkout]
    typealias To = [RideDetail]

    private let format = "%.2f"

    func translate(_ from: From) -> To {
        return from.map { workout in
            let distance = workout.totalDistance!.kilometers()
            let distanceText = String(format: format, distance)
            let dateText = workout.startDate.string(format: .yyyyMMddPd)
            let durationText = workout.duration.debugDescription
            return .init(distanceText: distanceText,
                         dateText: dateText,
                         durationText: durationText)
        }
    }
}
