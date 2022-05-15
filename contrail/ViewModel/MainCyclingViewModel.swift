//
//  MainCyclingViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/05/14.
//

import HealthKit

final class MainCyclingViewModel: ObservableObject {
    @Published var data: CyclingDistanceListViewModel = .generateEmpty()

    private var healthStore: HKHealthStore!

    init() {
        self.healthStore = HKHealthStore()
        let readTypes = Set([
            HKObjectType.workoutType()
        ])
        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            guard error == nil else {
                // TODO: [#32] HealthKitClient のエラーハンドリングを追加する
                return
            }
            guard success else {
                // TODO: [#32] HealthKitClient のエラーハンドリングを追加する
                return
            }
            self.fetchWorkouts()
        }
    }

    private func fetchWorkouts() {
        let type = HKWorkoutType.workoutType()
        let predicate = HKQuery.predicateForWorkouts(with: .cycling)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        let query = HKSampleQuery(sampleType: type,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: [sortDescriptor]) { _, samples, error in
            guard let workouts = samples as? [HKWorkout],
                  error == nil else {
                return
            }
            let sortedWorkouts = workouts.sorted(by: { (lw, rw) -> Bool in
                lw.startDate < rw.startDate
            })
            DispatchQueue.main.async {
                self.data = CyclingDistanceListTranslator().translate(sortedWorkouts.reversed())
            }

        }
        healthStore?.execute(query)
    }
}
