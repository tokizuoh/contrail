//
//  WorkoutListView.swift
//  contrail
//
//  Created by tokizo on 2022/08/14.
//

import SwiftUI

struct WorkoutListView: View {
    @ObservedObject var viewModel = WorkoutListVideModel(workoutsCacher: WorkoutsCacher.shared)

    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading,
                spacing: 5
            ) {
                ForEach(viewModel.data.workoutCellItems) { item in
                    TopWorkoutCell(item: item)
                }
            }
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}

struct WorkoutListData {
    let workoutCellItems: [TopWorkoutCellItem]

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

struct WorkoutListScreenBuilder {
    static func build() -> UIHostingController<WorkoutListView> {
        let vc = UIHostingController(rootView: WorkoutListView())
        return vc
    }
}
