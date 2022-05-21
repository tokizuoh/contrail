//
//  HealthKitClient.swift
//  contrail
//
//  Created by tokizo on 2022/05/15.
//

import HealthKit

public protocol HealthKitClientProtocol {
    func requestAuthorization() async throws
    func fetchWorkouts(completion: @escaping (([HKWorkout]) -> Void))
}

final class HealthKitClient: HealthKitClientProtocol {
    private let healthStore = HKHealthStore()

    func requestAuthorization() async throws {
        let readTypes = Set([
            HKObjectType.workoutType()
        ])

        try await healthStore.requestAuthorization(toShare: Set([]), read: readTypes)
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
        healthStore.execute(query)
    }
}
