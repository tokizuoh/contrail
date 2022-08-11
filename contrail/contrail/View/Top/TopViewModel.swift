//
//  TopViewModel.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import HealthKit

final class MainViewModel: ObservableObject {
    let workoutsCacher: WorkoutsCacherProtocol

    init(workoutsCacher: WorkoutsCacherProtocol) {
        self.workoutsCacher = workoutsCacher
    }
}
