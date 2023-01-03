//
//  PeriodChartScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2023/01/02.
//

import SwiftUI

struct PeriodChartScreenBuilder {
    static func build() -> UIHostingController<PeriodChartScreen?> {
        let vc = UIHostingController<PeriodChartScreen?>(rootView: nil)
        let viewModel = PeriodChartScreenViewModel(workoutsCacher: WorkoutsCacher.shared)
        let rootView = PeriodChartScreen(viewModel: viewModel)
        vc.rootView = rootView
        return vc
    }
}