//
//  TopScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/08/14.
//

import SwiftUI

struct TopScreenBuilder {
    static func build() -> UIHostingController<TopScreen?> {
        let vc = UIHostingController<TopScreen?>(rootView: nil)
        let rootView = TopScreen(
            showWorkoutListScreenAction: {
                let hostingController = WorkoutListScreenBuilder.build()
                vc.navigationController?.pushViewController(hostingController, animated: true)
            }
        )
        vc.rootView = rootView
        return vc
    }
}
