//
//  WorkoutsCacher.swift
//  contrail
//
//  Created by tokizo on 2022/05/15.
//

import HealthKit

/// @mockable
public protocol WorkoutsCacherProtocol {
    func cacheWorkouts(_ cachedWorkouts: [HKWorkout])
    func getWorkouts() -> [HKWorkout]?
}

final class WorkoutsCacher: WorkoutsCacherProtocol {
    static let shared = WorkoutsCacher()

    private init() {}

    private var cachedWorkouts: [HKWorkout]?

    func cacheWorkouts(_ cachedWorkouts: [HKWorkout]) {
        self.cachedWorkouts = cachedWorkouts
    }

    func getWorkouts() -> [HKWorkout]? {
        return cachedWorkouts
    }

}
