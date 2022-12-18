//
//  WorkoutListDataTranslator.swift
//  contrail
//
//  Created by tokizo on 2022/12/18.
//

import HealthKit

struct WorkoutListDataTranslator: Translator {
    typealias From = [HKWorkout]
    typealias To = WorkoutListData

    static func translate(_ from: From) -> To {
        let section = To.Section(
            headerItem: .init(date: Date(), totalWorkoutCount: 7, totalDistance: 127.0), itemList: WorkoutListItemTranslator.translate(from))
        return .init(sectionList: [section])
    }

    static private func makeSectionList(_ from: From) -> [To.Section] {

        return []
    }
}
