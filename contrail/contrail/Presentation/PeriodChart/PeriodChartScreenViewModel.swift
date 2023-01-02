//
//  PeriodChartScreenViewModel.swift
//  contrail
//
//  Created by tokizo on 2023/01/02.
//

import SwiftUI
import HealthKit

struct PeriodChartData {
    let chartItem: (total: Double, items: [ChartItem])

    static var empty: Self {
        return .init(chartItem: (total: 0, items: []))
    }
}

final class PeriodChartScreenViewModel: ObservableObject {
    @Published var data: PeriodChartData = .empty
    private let workoutsCacher: WorkoutsCacherProtocol

    init(workoutsCacher: WorkoutsCacherProtocol) {
        self.workoutsCacher = workoutsCacher
    }

    func dispatch() {
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }

        data = PeriodChartDataTranslator.translate(workouts)
        print(data)
    }
}

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
