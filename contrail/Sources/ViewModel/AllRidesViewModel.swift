//
//  AllRidesViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/05/15.
//

import Foundation

final class AllRidesViewModel: ObservableObject {
    @Published var data: [RideDetail] = []
    let cacher = WorkoutsCacher.shared

    init() {
        let workouts = cacher.getWorkouts() ?? []
        self.data = AllRidesTranslator().translate(workouts)
    }
}
