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
            let durationText = makeDurationText(workout.duration)
            return .init(distanceText: distanceText,
                         dateText: dateText,
                         durationText: durationText,
                         averageSpeedText: "")
        }
    }

    private func makeDurationText(_ timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: timeInterval)!
    }
}
