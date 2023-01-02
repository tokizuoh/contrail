//
//  SummaryScreenViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import HealthKit

struct SummaryScreenData {
    let highlightItems: [HighlightItem]
    let workoutItems: [WorkoutItem]

    static func empty() -> Self {
        return .init(
            highlightItems: [],
            workoutItems: []
        )
    }
}

final class SummaryScreenViewModel: ObservableObject {
    @Published var data: SummaryScreenData = .empty()

    private let workoutsCacher: WorkoutsCacherProtocol
    private let routeToPeriodChartScreenAction: () -> Void
    private let routeToWorkoutListScreenAction: () -> Void

    init(
        workoutsCacher: WorkoutsCacherProtocol,
        routeToPeriodChartScreenAction: @escaping () -> Void,
        routeToWorkoutListScreenAction: @escaping () -> Void
    ) {
        self.workoutsCacher = workoutsCacher
        self.routeToPeriodChartScreenAction = routeToPeriodChartScreenAction
        self.routeToWorkoutListScreenAction = routeToWorkoutListScreenAction
    }

    func dispatch() {
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }

        data = SummaryScreenDataTranslator.translate(workouts)
    }

    func routeToPeriodChartScreen() {
        routeToPeriodChartScreenAction()
    }

    func routeToWorkoutListScreen() {
        routeToWorkoutListScreenAction()
    }
}
