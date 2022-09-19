//
//  AbstractScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/08/14.
//

import SwiftUI

struct AbstractScreenBuilder {
    static func build() -> UIHostingController<TopScreen?> {
        let vc = UIHostingController<TopScreen?>(rootView: nil)
        let rootView = TopScreen(
            showAnalyticsScreenAction: {
                let hostingController = AnalyticsDetailScreenBuilder.build()
                vc.navigationController?.pushViewController(hostingController, animated: true)
            }, showAnalyticsYearlyScreenAction: {
                let hostingController = AnalyticsDetailYearlyScreenBuilder.build()
                vc.navigationController?.pushViewController(hostingController, animated: true)
            }, showWorkoutListScreenAction: {
                let hostingController = WorkoutListScreenBuilder.build()
                vc.navigationController?.pushViewController(hostingController, animated: true)
            }
        )
        vc.rootView = rootView
        return vc
    }
}
