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
        let descriptor = HKSampleQueryDescriptor(
            predicates: [
                .sample(
                    type: .workoutType(),
                    predicate: HKQuery.predicateForWorkouts(with: .cycling)
                )
            ],
            sortDescriptors: [.init(\.startDate, order: .reverse)]
        )
        let results = try await descriptor.result(for: healthStore)
        return results as? [HKWorkout] ?? []
    }
}
