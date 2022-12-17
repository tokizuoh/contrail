//
//  AbstractViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import HealthKit

struct TopData {
    let topAnalyticsItem: TopAnalyticsItem
    let workoutCellItems: [WorkoutAbstractViewItem]

    static func empty() -> Self {
        return .init(topAnalyticsItem: .init(allTotalDistanceText: "0",
                                             maxDistanceText: "0",
                                             thisMonthTotalDistanceText: "0"),
                     workoutCellItems: [])
    }
}

final class AbstractViewModel: ObservableObject {
    @Published var data: TopData = .empty()
    private let workoutsCacher: WorkoutsCacherProtocol

    init(workoutsCacher: WorkoutsCacherProtocol) {
        self.workoutsCacher = workoutsCacher
    }

    func dispatch() {
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }
        let cyclingWorkouts: [HKWorkout] = workouts.filter { workout in
            return workout.workoutActivityType == .cycling
        }
        let topItem = TopTranslator.translate(cyclingWorkouts)
        data = topItem
    }
}

struct TopTranslator: Translator {
    typealias From = [HKWorkout]
    typealias To = TopData

    static private let format = "%.2f"

    static func translate(_ from: From) -> To {
        return .init(
            topAnalyticsItem: makeAnalyticsItem(from),
            workoutCellItems: WorkoutCellTranslator.translate(from.prefix(5).map { $0 })
        )
    }

    // MARK: - makeAnalyticsItem
    private static func makeAnalyticsItem(_ from: From) -> TopAnalyticsItem {
        return .init(
            allTotalDistanceText: makeAllTotalDistanceText(from),
            maxDistanceText: makeMaxDistanceText(from),
            thisMonthTotalDistanceText: makeThisMonthTotalDistanceText(from)
        )
    }

    private static func makeAllTotalDistanceText(_ from: From) -> String {
        let allTotalDistance = from.reduce(0.0) { totalDistance, workout in
            return totalDistance + (workout.totalDistance?.kilometers() ?? 0.0)
        }
        return String(format: format, allTotalDistance)
    }

    private static func makeMaxDistanceText(_ from: From) -> String {
        let maxDistance = from.reduce(0.0) { maxDistance, workout in
            let distance = workout.totalDistance?.kilometers() ?? 0.0
            return maxDistance > distance ? maxDistance : distance
        }
        return String(format: format, maxDistance)
    }

    private static func makeThisMonthTotalDistanceText(_ from: From) -> String {
        let today = Date(timeIntervalSinceNow: 60 * 60 * 9)
        let calendar = Calendar(identifier: .japanese)
        let thisMonthTotalDistance = from.reduce(0.0) { totalDistance, workout in
            guard calendar.isDate(
                today,
                equalTo: workout.startDate,
                toGranularity: .month
            ) else {
                return totalDistance
            }
            return totalDistance + (workout.totalDistance?.kilometers() ?? 0.0)
        }
        return String(format: format, thisMonthTotalDistance)
    }
}
