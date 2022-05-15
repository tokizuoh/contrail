//
//  WorkoutsCacher.swift
//  contrail
//
//  Created by tokizo on 2022/05/15.
//

import HealthKit

final class WorkoutsCacher {
    static let shared = WorkoutsCacher()

    private init() {}

    private var cachedWorkouts: [HKWorkout] = []

    func cacheWorkouts(_ cachedWorkouts: [HKWorkout]) {
        self.cachedWorkouts = cachedWorkouts
    }

    func getWorkouts() -> [HKWorkout] {
        return cachedWorkouts
    }

}
