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
    }
}
