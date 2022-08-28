//
//  AnalyticsDetailViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/08/28.
//

import HealthKit

struct AnalyticsDetailData {
    let workoutItems: [AnalyticsDetailWorkoutItem]

    static func empty() -> Self {
        return .init(workoutItems: [])
    }
}

final class AnalyticsDetailViewModel: ObservableObject {
    @Published var data: AnalyticsDetailData = .empty()
    private let workoutsCacher: WorkoutsCacherProtocol

    init(workoutsCacher: WorkoutsCacherProtocol) {
        self.workoutsCacher = workoutsCacher
    }

    func dispatch() {
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }
        data = AnalyticsDetailTranslator.translate(workouts)
    }
}

struct AnalyticsDetailTranslator {
    typealias From = [HKWorkout]
    typealias To = AnalyticsDetailData

    static func translate(_ from: From) -> To {
        let workoutItems: [AnalyticsDetailWorkoutItem] = from.compactMap { workout in
            guard let distance = workout.totalDistance?.kilometers() else {
                return nil
            }
            return .init(
                date: workout.startDate,
                distance: distance
            )
        }
        return .init(workoutItems: workoutItems)
    }
}
