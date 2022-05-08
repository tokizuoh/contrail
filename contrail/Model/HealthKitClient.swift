//
//  HealthKitClient.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import HealthKit

protocol HealthKitClientProtocol {
    func getWorkouts() -> [HKWorkout]?
}

final class HealthKitClient: HealthKitClientProtocol {
    private var healthStore: HKHealthStore!
    private var workouts: [HKWorkout]?
    
    static let shared = HealthKitClient()
    
    private init() {
        self.healthStore = HKHealthStore()
        let readTypes = Set([
            HKObjectType.workoutType()
        ])
        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            guard error == nil else {
                // TODO: エラーハンドリング
                return
            }
            guard success else {
                // TODO: エラーハンドリング
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
            self.workouts = workouts.sorted(by: { (lw, rw) -> Bool in
                lw.startDate < rw.startDate
            })
        }
        healthStore?.execute(query)
    }
    
    func getWorkouts() -> [HKWorkout]? {
        return workouts
    }
}
