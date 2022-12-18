//
//  WorkoutListScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/12/18.
//

import SwiftUI

struct WorkoutListScreenBuilder {
    static func build() -> UIHostingController<WorkoutListScreen?> {
        let vc = UIHostingController<WorkoutListScreen?>(rootView: nil)
        let viewModel = WorkoutListScreenViewModel(workoutsCacher: WorkoutsCacher.shared)
        let rootView = WorkoutListScreen(viewModel: viewModel)
        vc.rootView = rootView
        return vc
    }
}
