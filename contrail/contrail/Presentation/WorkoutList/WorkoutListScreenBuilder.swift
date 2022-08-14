//
//  WorkoutListScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/08/14.
//

import SwiftUI

struct WorkoutListScreenBuilder {
    static func build() -> UIHostingController<WorkoutListView> {
        let vc = UIHostingController(rootView: WorkoutListView())
        return vc
    }
}
