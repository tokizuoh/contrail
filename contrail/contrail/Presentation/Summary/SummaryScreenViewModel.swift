//
//  SummaryScreenViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import HealthKit

struct SummaryScreenData {
    let chartViewItem: SummaryChartViewItem
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

final class SummaryScreenViewModel: ObservableObject {
    @Published var data: SummaryScreenData = .empty()

    private let workoutsCacher: WorkoutsCacherProtocol
    private let routeToWorkoutListScreenAction: () -> Void

    init(
        workoutsCacher: WorkoutsCacherProtocol,
        routeToWorkoutListScreenAction: @escaping () -> Void
    ) {
        self.workoutsCacher = workoutsCacher
        self.routeToWorkoutListScreenAction = routeToWorkoutListScreenAction
    }

    func dispatch() {
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }

        data = SummaryScreenDataTranslator.translate(workouts)
    }

    func routeToWorkoutListScreen() {
        routeToWorkoutListScreenAction()
    }
}

struct WorkoutListItemTranslator {
    typealias From = [HKWorkout]
    typealias To = [WorkoutItem]

    static private let format = "%.2f"

    static func translate(_ from: From, toGranularity component: Calendar.Component? = nil) -> To {
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
        return workoutItems.sorted(by: { li, ri in
            li.dateString < ri.dateString
        }).reversed()
    }
}
