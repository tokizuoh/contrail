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
    let cacher: WorkoutsCacherProtocol

    init(cacher: WorkoutsCacherProtocol) {
        self.cacher = cacher
    }

    func fetch() async {
        await requestAuthorization()
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

    private func requestAuthorization() async {
        do {
            try await client.requestAuthorization()
        } catch let error {
            print(error)
        }
    }
}
