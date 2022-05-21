//
//  MainViewModelTests.swift
//  contrailTests
//
//  Created by tokizo on 2022/05/21.
//

import XCTest
import HealthKit
@testable import contrail

final class MainViewModelTests: XCTestCase {
    func test_WorkoutsCacherの保存ができること_取得ができること() async throws {
        let cacher = WorkoutsCacher.shared
        let workout = HKWorkout(activityType: .americanFootball,
                                start: Date(),
                                end: Date())
        cacher.cacheWorkouts([workout])
        XCTAssertEqual(cacher.getWorkouts()?.first, workout)
    }
}
