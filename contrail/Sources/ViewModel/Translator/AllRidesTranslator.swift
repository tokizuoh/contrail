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
            let averageSpeedText = makeAverageSpeedText(timeInterval: workout.duration,
                                                        distance: distance)
            let gainedElevationText = makeGainedElevationText(workout)
            return .init(distanceText: distanceText,
                         dateText: dateText,
                         durationText: durationText,
                         averageSpeedText: averageSpeedText,
                         gainedElevationText: gainedElevationText)
        }
    }

    private func makeDurationText(_ timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: timeInterval)!
    }

    private func makeAverageSpeedText(timeInterval: TimeInterval, distance: Double) -> String {
        let averageSpeed = distance / ((Double)(Int(timeInterval)) / 3600)
        return String(format: format, averageSpeed)
    }

    private func makeGainedElevationText(_ workout: HKWorkout) -> String? {
        guard let gainedElevation = workout.metadata?[HKMetadataKeyElevationAscended] as? HKQuantity else {
            return nil
        }

        return gainedElevation.doubleValue(for: .meter()).description
    }
}
