//
//  MainViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/05/14.
//

import HealthKit

final class MainViewModel: ObservableObject {
    @Published var data: RideList = .generateEmpty()
    let cacher: WorkoutsCacherProtocol
    let client: HealthKitClientProtocol

    init(
        cacher: WorkoutsCacherProtocol,
        client: HealthKitClientProtocol
    ) {
        self.cacher = cacher
        self.client = client
    }

    func fetch() async {
        await requestAuthorization()

        // TODO: エラーハンドリング
        let workouts = try! await client.fetchWorkouts()
        self.cacher.cacheWorkouts(workouts)
        DispatchQueue.main.async {
            let workouts = self.cacher.getWorkouts() ?? []
            self.data = RideListTranslator().translate(workouts)
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
