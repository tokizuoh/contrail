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
        data = AnalyticsDetailYearlyTranslator.translate(workouts, option: .yearly)
        print(data.chartViewItem.workoutItems)
    }
}

struct AnalyticsDetailYearlyTranslator {
    typealias From = [HKWorkout]
    typealias To = AnalyticsDetailYearlyData

    enum Option {
        case yearly
    }

    static func translate(_ from: From, option: Option) -> To {
        let now = Date()
        var calendar = Calendar(identifier: .japanese)
        let timeZone = TimeZone(identifier: "Asia/Tokyo")!
        calendar.timeZone = timeZone
        calendar.locale = Locale(identifier: "ja_JP")

        let toGranularity: Calendar.Component = {
            switch option {
            case .yearly:
                return .year
            }
        }()

        var totalDistance: Double = 0.0
        let workoutItems: [AnalyticsDetailYearlyWorkoutItem] = from.compactMap { workout in
            guard let distance = workout.totalDistance?.kilometers(),
                  calendar.isDate(now, equalTo: workout.startDate, toGranularity: toGranularity) else {
                return nil
            }
            guard let workoutType: AnalyticsDetailYearlyWorkoutItem.WorkoutType = {
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

            let dateComponents = calendar.dateComponents([.timeZone, .calendar, .year, .month], from: workout.startDate)
            return .init(
                type: workoutType,
                date: dateComponents.date!,
                distance: distance
            )
        }
        let totalDistanceString = String(format: "%.2f", totalDistance)
        return .init(
            chartViewItem:
                .init(
                    totalDistanceString: totalDistanceString,
                    workoutItems: workoutItems
                )
        )
    }

}
