//
//  WorkoutListViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/08/14.
//

import Foundation

struct WorkoutListData {
    let workoutCellItems: [WorkoutAbstractViewItem]

    static func empty() -> Self {
        return .init(workoutCellItems: [])
    }
}

final class WorkoutListVideModel: ObservableObject {
    @Published var data: WorkoutListData = .empty()
    private let workoutsCacher: WorkoutsCacherProtocol

    init(workoutsCacher: WorkoutsCacherProtocol) {
        self.workoutsCacher = workoutsCacher
    }

    func dispatch() {
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }
        let workoutCellItems = WorkoutCellTranslator.translate(workouts)
        data = WorkoutListData(workoutCellItems: workoutCellItems)
    }
}
