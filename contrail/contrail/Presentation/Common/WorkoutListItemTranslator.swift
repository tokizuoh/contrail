//
//  WorkoutListItemTranslator.swift
//  contrail
//
//  Created by tokizo on 2023/01/01.
//

import HealthKit

struct WorkoutListItemTranslator {
    typealias From = [HKWorkout]
    typealias To = [WorkoutItem]

    static private let format = "%.2f"  // TODO: view側で丸める

    static func translate(_ from: From, count: Int? = nil, toGranularity component: Calendar.Component? = nil) -> To {
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
                case .walking:
                    return .walking
                default:
                    return nil
                }
            }() else {
                return nil
            }
            guard let distance = workout.totalDistance?.kilometers() else {
                return nil
            }
            if let component {
                guard calendar.isDate(now, equalTo: workout.startDate, toGranularity: component) else {
                    return nil
                }
            }
            let distanceString = String(format: format, distance)
            let dateString = workout.startDate.formatted(.dateTime.year().month(.twoDigits).day(.twoDigits)).replacingOccurrences(of: "/", with: ".")
            return .init(
                type: workoutType,
                distanceString: distanceString,
                dateString: dateString
            )
        }
        let sortedWorkoutItems = workoutItems.sorted(by: { li, ri in
            li.dateString < ri.dateString
        }).reversed()

        if sortedWorkoutItems.isEmpty {
            return []
        }

        if let count {
            return [WorkoutItem]([WorkoutItem](sortedWorkoutItems)[0..<count])
        } else {
            return [WorkoutItem](sortedWorkoutItems)
        }
    }
}
