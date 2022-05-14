//
//  CyclingDistanceListTranslator.swift
//  contrail
//
//  Created by tokizo on 2022/05/14.
//

import Foundation
import HealthKit

struct CyclingDistanceListTranslator {
    typealias From = [HKWorkout]
    typealias To = CyclingDistanceListViewModel

    func translate(_ from: From) -> To {
        return .init(cyclingTopViewModel: makeCyclingDistanceTopViewModel(from),
                     cyclingDistanceList: makeCyclingDistanceList(from))
    }

    private func makeCyclingDistanceTopViewModel(_ from: From) -> CyclingDistanceTopViewModel {
        let totalCyclingDistance = from.reduce(0.0) { t, workout in
            return t + workout.totalDistance!.kilometers()
        }
        let totalCyclingDistanceText = String(format: "%.2f", totalCyclingDistance)

        let maxDistancePerOneRide = from.reduce(0.0) { maxDistance, workout in
            let distance = workout.totalDistance!.kilometers()
            return maxDistance < distance ? distance : maxDistance
        }
        let maxDistancePerOneRideText = String(format: "%.2f", maxDistancePerOneRide)

        return .init(totalCyclingDistanceText: totalCyclingDistanceText,
                     maxDistancePerOneRideText: maxDistancePerOneRideText)
    }

    private func makeCyclingDistanceList(_ from: From) -> [CyclingDistance] {
        return from.map { workout in
            let distance = workout.totalDistance!.kilometers()
            let date = workout.startDate.string(format: .yyyyMMddPd)
            return .init(distance: distance,
                         date: date)
        }
    }
}

private extension HKQuantity {
    func kilometers() -> Double {
        return self.doubleValue(for: .meter()) / 1000
    }
}
