//
//  AbstractScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import SwiftUI

struct AbstractScreenBuilder {
    static func build() -> UIHostingController<AbstractScreen?> {
        let vc = UIHostingController<AbstractScreen?>(rootView: nil)
        let viewModel = AbstractScreenViewModel(workoutsCacher: WorkoutsCacher.shared)
        let rootView = AbstractScreen(viewModel: viewModel)
        vc.rootView = rootView
        return vc
    }
}
