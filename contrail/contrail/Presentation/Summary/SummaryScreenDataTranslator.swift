//
//  SummaryScreenDataTranslator.swift
//  contrail
//
//  Created by tokizo on 2022/12/24.
//

import HealthKit

struct SummaryScreenDataTranslator: Translator {
    typealias From = [HKWorkout]
    typealias To = SummaryScreenData

    static private let format = "%.2f"

    static func translate(_ from: From) -> SummaryScreenData {
        return SummaryScreenData(
            highlightItems: makeHighlightItems(from),
            workoutItems: makeWorkoutItems(from)
        )
    }

    static func makeWorkoutItems(_ from: From) -> [WorkoutItem] {
        let count = min(from.count, 3)
        return WorkoutListItemTranslator.translate(from, count: count)
    }

    // TODO: Detail作成後に移動する
    static private func makeChartViewItem(_ from: From) -> SummaryChartViewItem {
        let now = Date()
        var calendar = Calendar(identifier: .japanese)
        let timeZone = TimeZone(identifier: "Asia/Tokyo")!
        calendar.timeZone = timeZone
        calendar.locale = Locale(identifier: "ja_JP")

        var totalDistance: Double = 0.0
        let workoutItems: [SummaryChartViewWorkoutItem] = from.compactMap { workout in
            guard let distance = workout.totalDistance?.kilometers(),
                  calendar.isDate(now, equalTo: workout.startDate, toGranularity: .year) else {
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
}
