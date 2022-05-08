//
//  HealthKitClient.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import HealthKit

final class HealthKitClient: ObservableObject {
    private var healthStore: HKHealthStore!
    private var workouts: [HKWorkout]?
    @Published var cyclingDistanceList: [CyclingDistance] = []
    
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
            // TODO: わざわざ代入する必要ある？
            self.workouts = workouts.sorted(by: { (lw, rw) -> Bool in
                lw.startDate < rw.startDate
            })
            DispatchQueue.main.async {
                self.cyclingDistanceList = workouts.map { workout in
                    let distance = workout.totalDistance!.doubleValue(for: .meter()) / 1000
                    let date = workout.startDate.string(format: .yyyyMMddPd)
                    return .init(distance: distance,
                                 date: date)
                }
            }
            
        }
        healthStore?.execute(query)
    }
}
