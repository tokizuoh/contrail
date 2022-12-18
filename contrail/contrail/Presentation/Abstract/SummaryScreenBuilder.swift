//
//  SummaryScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import SwiftUI

struct SummaryScreenBuilder {
    static func build() -> UIHostingController<SummaryScreen?> {
        let vc = UIHostingController<SummaryScreen?>(rootView: nil)
        let viewModel = SummaryScreenViewModel(
            workoutsCacher: WorkoutsCacher.shared,
            routeToWorkoutListScreenAction: {
                let hostingController = WorkoutListScreenBuilder.build()
                vc.navigationController?.pushViewController(hostingController, animated: true)
            })
        let rootView = SummaryScreen(viewModel: viewModel)
        vc.rootView = rootView
        return vc
    }
}
