//
//  RootViewController.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import UIKit

final class RootViewController: UIViewController {
    let healthKitClient: HealthKitClientProtocol = HealthKitClient()
    let workoutsCacher: WorkoutsCacherProtocol = WorkoutsCacher.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                try await healthKitClient.requestAuthorization()
                let workout = try await healthKitClient.fetchWorkouts()
                workoutsCacher.cacheWorkouts(workout)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
