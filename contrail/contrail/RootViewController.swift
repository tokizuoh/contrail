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
                showTopScreen()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    private func showTopScreen() {
        // swiftlint:disable identifier_name
        let vc = TopScreenBuilder.build()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        present(navigationController, animated: true)
    }
}