//
//  SummaryScreenDataTranslator.swift
//  contrail
//
//  Created by tokizo on 2022/12/24.
//

import HealthKit

// TODO: Translatorに準拠させる
struct SummaryScreenDataTranslator {
    typealias From = [HKWorkout]
    typealias To = SummaryScreenData

    static private let format = "%.2f"

    enum Option {
        case yearly
    }

    static func makeChartViewItem(_ from: From, option: Option) -> SummaryChartViewItem {
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
        let workoutItems: [SummaryChartViewWorkoutItem] = from.compactMap { workout in
            guard let distance = workout.totalDistance?.kilometers(),
                  calendar.isDate(now, equalTo: workout.startDate, toGranularity: toGranularity) else {
                return nil
            }
            guard let workoutType: SummaryChartViewWorkoutItem.WorkoutType = {
                switch workout.workoutActivityType {
                case .cycling:
                    return .cycling
                case .running:
                    return .running
                case .walking:
                    return .walking
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
        WorkoutListItemTranslator.translate(from, toGranularity: .month)
    }
}
