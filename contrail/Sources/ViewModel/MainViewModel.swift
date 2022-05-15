//
//  MainViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/05/14.
//

import HealthKit

final class MainViewModel: ObservableObject {
    @Published var data: RideList = .generateEmpty()
    let client = HealthKitClient()
    let cacher = WorkoutsCacher.shared

    init() {
        client.fetchWorkouts { workouts in
            let sortedWorkouts = workouts.sorted(by: { (lw, rw) -> Bool in
                lw.startDate < rw.startDate
            })
            self.cacher.cacheWorkouts(sortedWorkouts.reversed())
            DispatchQueue.main.async {
                self.data = RideListTranslator().translate(self.cacher.getWorkouts())
            }
        }
    }
}
