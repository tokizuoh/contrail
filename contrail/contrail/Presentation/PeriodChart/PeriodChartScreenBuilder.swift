//
//  PeriodChartScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2023/01/02.
//

import SwiftUI

struct PeriodChartScreenBuilder {
    static func build(highlightType: HighlightType) -> UIHostingController<PeriodChartScreen?> {
        let vc = UIHostingController<PeriodChartScreen?>(rootView: nil)
        let viewModel = PeriodChartScreenViewModel(
            highlightType: highlightType,
            workoutsCacher: WorkoutsCacher.shared
        )
        let rootView = PeriodChartScreen(viewModel: viewModel, type: highlightType)
        vc.rootView = rootView
        return vc
    }
}
