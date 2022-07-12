//
//  RideListTranslator.swift
//  contrail
//
//  Created by tokizo on 2022/05/14.
//

import HealthKit

struct RideListTranslator {
    typealias From = [HKWorkout]
    typealias To = RideList

    private let format = "%.2f"

    func translate(_ from: From) -> To {
        return .init(rideStatistics: makeRideStatistics(from),
                     rides: makeRides(from))
    }

    private func makeRideStatistics(_ from: From) -> RideStatistics {
        let totalRideDistance = from.reduce(0.0) { t, workout in
            return t + workout.totalDistance!.kilometers()
        }
        let totalRideDistanceText = String(format: format, totalRideDistance)

        var maxDistanceDate = Date()
        let maxDistance = from.reduce(0.0) { maxDistance, workout in
            let distance = workout.totalDistance!.kilometers()
            if maxDistance < distance {
                maxDistanceDate = workout.startDate
                return distance
            } else {
                return maxDistance
            }
        }

        return .init(totalDistanceText: totalRideDistanceText,
                     maxDistanceText: String(format: format, maxDistance),
                     maxDistanceDate: maxDistanceDate.string(format: .yyyyMMddPd))
    }

    private func makeRides(_ from: From) -> [Ride] {
        return from.prefix(5).map { workout in
            let distance = workout.totalDistance!.kilometers()
            let distanceText = String(format: format, distance)
            let dateText = workout.startDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)).replacingOccurrences(of: "/", with: ".")

            return Ride(distanceText: distanceText,
                        dateText: dateText)
        }
    }
}

extension HKQuantity {
    func kilometers() -> Double {
        return self.doubleValue(for: .meter()) / 1000
    }
}
