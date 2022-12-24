//
//  HealthKitClient.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import HealthKit

public protocol HealthKitClientProtocol {
    func requestAuthorization() async throws
    func fetchWorkouts() async throws -> [HKWorkout]
}

final class HealthKitClient: HealthKitClientProtocol {
    private let healthStore = HKHealthStore()

    func requestAuthorization() async throws {
        let readTypes = Set([
            HKObjectType.workoutType()
        ])

        try await healthStore.requestAuthorization(toShare: Set([]), read: readTypes)
    }

    func fetchWorkouts() async throws -> [HKWorkout] {
        let cyclingDescriptor = HKSampleQueryDescriptor(
            predicates: [
                .sample(
                    type: .workoutType(),
                    predicate: HKQuery.predicateForWorkouts(with: .cycling)
                )
            ],
            sortDescriptors: [.init(\.startDate, order: .reverse)]
        )
        let runningDescriptor = HKSampleQueryDescriptor(
            predicates: [
                .sample(
                    type: .workoutType(),
                    predicate: HKQuery.predicateForWorkouts(with: .running)
                )
            ],
            sortDescriptors: [.init(\.startDate, order: .reverse)]
        )
        let walkingDescriptor = HKSampleQueryDescriptor(
            predicates: [
                .sample(
                    type: .workoutType(),
                    predicate: HKQuery.predicateForWorkouts(with: .walking)
                )
            ],
            sortDescriptors: [.init(\.startDate, order: .reverse)]
        )
        let cyclingResults = try await cyclingDescriptor.result(for: healthStore)
        let runningResults = try await runningDescriptor.result(for: healthStore)
        let walkingResults = try await walkingDescriptor.result(for: healthStore)
        guard let workouts = cyclingResults + runningResults + walkingResults as? [HKWorkout] else {
            return []
        }
        let sortedWorkouts = workouts.sorted { lw, rw in
            lw.startDate > rw.endDate
        }
        return sortedWorkouts
    }
}
