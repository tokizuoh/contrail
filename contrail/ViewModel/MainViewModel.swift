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

    init() {
        client.fetchWorkouts { workouts in
            let sortedWorkouts = workouts.sorted(by: { (lw, rw) -> Bool in
                lw.startDate < rw.startDate
            })
            DispatchQueue.main.async {
                self.data = CyclingDistanceListTranslator().translate(sortedWorkouts.reversed())
            }
        }
    }
}
