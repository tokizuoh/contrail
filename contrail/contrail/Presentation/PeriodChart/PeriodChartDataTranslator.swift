//
//  PeriodChartDataTranslator.swift
//  contrail
//
//  Created by tokizo on 2023/01/03.
//

import HealthKit

struct PeriodChartDataTranslator: Translator {
    typealias From = [HKWorkout]
    typealias To = PeriodChartData

    static func translate(_ from: From) -> To {
        let dateBeforeAWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        var total: Double = 0
        let chartItems: [ChartItem] = from.compactMap { workout in
            guard workout.startDate > dateBeforeAWeek,
                  let statistics = workout.statistics(for: HKQuantityType(.activeEnergyBurned)),
                  let kilocalorie = statistics.sumQuantity()?.doubleValue(for: .kilocalorie()) else {
                return nil
            }
            total += kilocalorie
            return ChartItem(
                date: workout.startDate,
                quantity: kilocalorie
            )
        }
        return To(chartItem: (total: total, items: chartItems))
    }
}
