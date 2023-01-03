//
//  PeriodChartDataTranslator.swift
//  contrail
//
//  Created by tokizo on 2023/01/03.
//

import HealthKit

struct PeriodChartDataTranslator: Translator {
    typealias To = PeriodChartData

    struct From {
        let workouts: [HKWorkout]
        let type: HighlightType
    }

    static private let targetWorkoutTypes: [HKWorkoutActivityType] = [
        .cycling,
        .running,
        .walking
    ]

    static func translate(_ from: From) -> PeriodChartData {
        let dateBeforeAWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        var total: Double = 0

        let chartItems: [ChartItem] = from.workouts.compactMap { workout in
            guard workout.startDate > dateBeforeAWeek else {
                return nil
            }

            let quantity: Double? = {
                switch from.type {
                case .distance:
                    guard targetWorkoutTypes.contains(workout.workoutActivityType),
                          let distance = workout.totalDistance?.kilometers() else {
                        return nil
                    }
                    return distance
                case .kilocalories:
                    guard let statistics = workout.statistics(for: HKQuantityType(.activeEnergyBurned)),
                          let kilocalorie = statistics.sumQuantity()?.doubleValue(for: .kilocalorie()) else {
                        return nil
                    }
                    return kilocalorie
                }
            }()

            guard let quantity else {
                return nil
            }

            total += quantity
            return ChartItem(
                date: workout.startDate,
                quantity: quantity
            )
        }
        return PeriodChartData(chartItem: (total: total, items: chartItems))
    }
}
