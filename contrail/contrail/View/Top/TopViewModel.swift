//
//  TopViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import HealthKit
import Apollo

struct TopItem {
    let topStatisticsItem: TopStatisticsItem
    let workoutCellItems: [TopWorkoutCellItem]

    static func empty() -> Self {
        return .init(topStatisticsItem: .init(allTotalDistanceText: "0",
                                              maxDistanceText: "0",
                                              thisMonthTotalDistanceText: "0"),
                     workoutCellItems: [])
    }
}

final class TopViewModel: ObservableObject {
    @Published var data: TopItem = .empty()
    private let workoutsCacher: WorkoutsCacherProtocol

    init(workoutsCacher: WorkoutsCacherProtocol) {
        self.workoutsCacher = workoutsCacher
    }

    func dispatch() {
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }
        let topItem = TopTranslator.translate(workouts)
        data = topItem
    }

    func uploadWorkout() {
        //        Network.shared.apollo.fetch(query: GetWorkoutQuery()) { result in
        //            switch result {
        //            case .success(let data):
        //                print("Success!")
        //                print(data)
        //            case .failure(let error):
        //                fatalError(error.localizedDescription)
        //            }
        //        }
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }

        for workout in workouts {
            Network.shared.apollo.perform(
                mutation: CreateWorkoutMutation(
                    distance: workout.totalDistance?.kilometers() ?? 0.0,
                    duration: workout.duration,
                    startDate: workout.startDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)).replacingOccurrences(of: "/", with: "."),
                    type: .cycling
                )
            ) { result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        }

    }
}

struct TopTranslator {
    typealias From = [HKWorkout]
    typealias To = TopItem

    static private let format = "%.2f"

    static func translate(_ from: From) -> To {
        return .init(
            topStatisticsItem: makeStatisticsItem(from),
            workoutCellItems: makeWorkoutCellItems(from)
        )
    }

    // MARK: - makeStatisticsItem
    private static func makeStatisticsItem(_ from: From) -> TopStatisticsItem {
        // TODO: 3回走査するの改善できそう
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

    // MARK: - makeWorkoutCellItems
    private static func makeWorkoutCellItems(_ from: From) -> [TopWorkoutCellItem] {
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
