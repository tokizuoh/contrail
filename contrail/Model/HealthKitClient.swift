//
//  HealthKitClient.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import HealthKit

final class HealthKitClient {
    static let shared = HealthKitClient()
   
    var healthStore: HKHealthStore!
    var workouts: [HKWorkout]? {
        didSet {
            guard let workouts = workouts else {
                return
            }
            for workout in workouts {
                print(workout.totalDistance)
            }
        }
    }
    
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
            self.getWorkouts()
        }
    }
    
    private func getWorkouts() {
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
}
