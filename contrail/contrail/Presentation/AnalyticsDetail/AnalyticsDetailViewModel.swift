//
//  AnalyticsDetailViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/08/28.
//

import HealthKit

struct AnalyticsDetailData {
    let chartViewItem: AnalyticsDetailChartViewItem

    static func empty() -> Self {
        return .init(
            chartViewItem: .init(
                totalDistanceString: "",
                workoutItems: []
            )
        )
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
        data = AnalyticsDetailTranslator.translate(workouts, option: .monthly)
    }
}

struct AnalyticsDetailTranslator {
    typealias From = [HKWorkout]
    typealias To = AnalyticsDetailData

    enum Option {
        case monthly
    }

    static func translate(_ from: From, option: Option) -> To {
        let now = Date()
        var calendar = Calendar(identifier: .japanese)
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        calendar.locale = Locale(identifier: "ja_JP")

        let toGranularity: Calendar.Component = {
            switch option {
            case .monthly:
                return .month
            }
        }()

        var totalDistance: Double = 0.0
        let workoutItems: [AnalyticsDetailWorkoutItem] = from.compactMap { workout in
            guard let distance = workout.totalDistance?.kilometers(),
                  calendar.isDate(now, equalTo: workout.startDate, toGranularity: toGranularity) else {
                return nil
            }
            guard let workoutType: AnalyticsDetailWorkoutItem.WorkoutType = {
                switch workout.workoutActivityType {
                case .cycling:
                    return .cycling
                case .running:
                    return .running
                default:
                    return nil
                }
            }() else {
                return nil
            }
            totalDistance += distance
            return .init(
                type: workoutType,
                date: workout.startDate,
                distance: distance
            )
        }
        return .init(
            chartViewItem:
                .init(
                    totalDistanceString: totalDistance.description,
                    workoutItems: workoutItems)
        )
    }

}
