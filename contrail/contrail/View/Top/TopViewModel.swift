//
//  TopViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import HealthKit

final class TopViewModel: ObservableObject {
    @Published var data: [TopWorkoutCellItem] = []
    private let workoutsCacher: WorkoutsCacherProtocol

    init(workoutsCacher: WorkoutsCacherProtocol) {
        self.workoutsCacher = workoutsCacher
    }

    func dispatch() {
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }
        data = TopTranslator.translate(workouts)
    }
}

struct TopTranslator {
    typealias From = [HKWorkout]
    typealias To = [TopWorkoutCellItem]

    static private let format = "%.2f"

    static func translate(_ from: From) -> To {
        return from.map { workout in
            let distance = workout.totalDistance!.kilometers()
            let distanceText = String(format: format, distance)
            let dateText = workout.startDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)).replacingOccurrences(of: "/", with: ".")
            return .init(
                distanceText: distanceText,
                dateText: dateText
            )
        }
    }
}

private extension HKQuantity {
    func kilometers() -> Double {
        return self.doubleValue(for: .meter()) / 1000
    }
}
