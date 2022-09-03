//
//  AnalyticsDetailYearlyViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import HealthKit

struct AnalyticsDetailYearlyData {
    let chartViewItem: AnalyticsDetailYearlyChartViewItem

    static func empty() -> Self {
        return .init(
            chartViewItem: .init(
                totalDistanceString: "",
                workoutItems: []
            )
        )
    }
}

final class AnalyticsDetailYearlyViewModel: ObservableObject {
    @Published var data: AnalyticsDetailYearlyData = .empty()
    private let workoutsCacher: WorkoutsCacherProtocol

    init(workoutsCacher: WorkoutsCacherProtocol) {
        self.workoutsCacher = workoutsCacher
    }

    func dispatch() {
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }
        //        data = AnalyticsDetailTranslator.translate(workouts, option: .monthly)
    }
}
