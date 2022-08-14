//
//  HKQuantity+.swift
//  contrail
//
//  Created by tokizo on 2022/08/14.
//

import HealthKit

extension HKQuantity {
    func kilometers() -> Double {
        return self.doubleValue(for: .meter()) / 1000
    }
}
