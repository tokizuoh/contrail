//
//  AnalyticsDetailYearlyViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import HealthKit

struct AnalyticsDetailYearlyData {
    let chartViewItem: AnalyticsDetailYearlyChartViewItem
    let workoutItems: [WorkoutItem]

    static func empty() -> Self {
        return .init(
            chartViewItem: .init(
                totalDistanceString: "",
                workoutItems: []
            ),
            workoutItems: []
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
        let chartViewItem = AnalyticsDetailYearlyTranslator.makeChartViewItem(workouts, option: .yearly)
        let workoutItems: [WorkoutItem] = AnalyticsDetailYearlyTranslator.makeWorkoutItems(workouts)
        data = .init(
            chartViewItem: chartViewItem,
            workoutItems: workoutItems
        )
    }
}

// TODO: Translatorに準拠させる
struct AnalyticsDetailYearlyTranslator {
    typealias From = [HKWorkout]
    typealias To = AnalyticsDetailYearlyData

    static private let format = "%.2f"

    enum Option {
        case yearly
    }

    static func makeChartViewItem(_ from: From, option: Option) -> AnalyticsDetailYearlyChartViewItem {
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
            totalDistanceString: totalDistanceString,
            workoutItems: workoutItems.sorted(by: { li, ri in
                li.date < ri.date
            })
        )
    }

    static func makeWorkoutItems(_ from: From) -> [WorkoutItem] {
        let workoutItems: [WorkoutItem] = from.compactMap { workout in
            let now = Date()
            var calendar = Calendar(identifier: .japanese)
            let timeZone = TimeZone(identifier: "Asia/Tokyo")!
            calendar.timeZone = timeZone
            calendar.locale = Locale(identifier: "ja_JP")

            guard let workoutType: WorkoutItem.WorkoutType = {
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
            guard let distance = workout.totalDistance?.kilometers() else {
                return nil
            }
            guard calendar.isDate(now, equalTo: workout.startDate, toGranularity: .month) else {
                return nil
            }
            let distanceString = String(format: format, distance)
            let dateString = workout.startDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)).replacingOccurrences(of: "/", with: ".")
            return .init(
                type: workoutType,
                distanceString: distanceString,
                dateString: dateString
            )
        }
        return workoutItems.sorted(by: { li, ri in
            li.dateString < ri.dateString
        }).reversed()
    }
}
