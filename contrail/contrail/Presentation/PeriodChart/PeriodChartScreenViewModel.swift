//
//  PeriodChartScreenViewModel.swift
//  contrail
//
//  Created by tokizo on 2023/01/02.
//

import SwiftUI
import HealthKit

struct PeriodChartData {
    let chartItems: [ChartItem]

    static var empty: Self {
        return .init(chartItems: [])
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
        let chartItems: [ChartItem] = from.compactMap { workout in
            guard workout.startDate > dateBeforeAWeek,
                  let statistics = workout.statistics(for: HKQuantityType(.activeEnergyBurned)),
                  let kilocalorie = statistics.sumQuantity()?.doubleValue(for: .kilocalorie()) else {
                return nil
            }
            return ChartItem(
                date: workout.startDate,
                quantity: kilocalorie
            )
        }
        return To(chartItems: chartItems)
    }
}
