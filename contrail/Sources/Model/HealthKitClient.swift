//
//  HealthKitClient.swift
//  contrail
//
//  Created by tokizo on 2022/05/15.
//

import HealthKit

final class HealthKitClient {

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
        }
    }

    func fetchWorkouts(completion: @escaping (([HKWorkout]) -> Void)) {
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
                // TODO: [#32] HealthKitClient のエラーハンドリングを追加する
                return
            }
            completion(workouts)
        }
        healthStore?.execute(query)
    }

}
