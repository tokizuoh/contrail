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
        let cyclingTopViewModel = makeCyclingDistanceTopViewModel(from)
        return .init(cyclingTopViewModel: cyclingTopViewModel,
                     cyclingDistanceList: []) // TODO: [#39]
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
}

private extension HKQuantity {
    func kilometers() -> Double {
        return self.doubleValue(for: .meter()) / 1000
    }
}
