//
//  WorkoutListScreenViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/12/18.
//

import SwiftUI

struct WorkoutListData {
    let sectionList: [Section]

    struct Section: Identifiable {
        var id = UUID()

        let headerItem: HeaderItem
        let itemList: [WorkoutItem]
    }

    struct HeaderItem {
        let date: Date
        let totalWorkoutCount: Int
        let totalDistance: Double
    }

    static var empty: Self {
        return .init(sectionList: [])
    }
}

final class WorkoutListScreenViewModel: ObservableObject {
    @Published var data: WorkoutListData = .empty
    private let workoutsCacher: WorkoutsCacherProtocol

    init(workoutsCacher: WorkoutsCacherProtocol) {
        self.workoutsCacher = workoutsCacher
    }

    func dispatch() {
        guard let workouts = workoutsCacher.getWorkouts() else {
            return
        }

        data = WorkoutListDataTranslator.translate(workouts)
    }
}

