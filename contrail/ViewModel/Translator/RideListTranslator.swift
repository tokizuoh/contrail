//
//  RideListTranslator.swift
//  contrail
//
//  Created by tokizo on 2022/05/14.
//

import Foundation
import HealthKit

struct RideListTranslator {
    typealias From = [HKWorkout]
    typealias To = RideList

    private let format = "%.2f"

    func translate(_ from: From) -> To {
        return .init(rideAggregation: makeRideAggregation(from),
                     rides: makeRides(from))
    }

    private func makeRideAggregation(_ from: From) -> RideAggregation {
        let totalRideDistance = from.reduce(0.0) { t, workout in
            return t + workout.totalDistance!.kilometers()
        }
        let totalRideDistanceText = String(format: format, totalRideDistance)

        let maxDistancePerOneRide = from.reduce(0.0) { maxDistance, workout in
            let distance = workout.totalDistance!.kilometers()
            return maxDistance < distance ? distance : maxDistance
        }
        let maxDistancePerOneRideText = String(format: format, maxDistancePerOneRide)

        return .init(totalDistanceText: totalRideDistanceText,
                     maxDistancePerOneRideText: maxDistancePerOneRideText)
    }

    private func makeRides(_ from: From) -> [Ride] {
        return from.map { workout in
            let distance = workout.totalDistance!.kilometers()
            let distanceText = String(format: format, distance)
            let dateText = workout.startDate.string(format: .yyyyMMddPd)

            return Ride(distanceText: distanceText,
                        dateText: dateText)
        }
    }
}

private extension HKQuantity {
    func kilometers() -> Double {
        return self.doubleValue(for: .meter()) / 1000
    }
}
