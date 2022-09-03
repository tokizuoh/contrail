//
//  AnalyticsDetailYearlyScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import SwiftUI

struct AnalyticsDetailYearlyScreenBuilder {
    static func build() -> UIHostingController<AnalyticsDetailYearlyScreen?> {
        let vc = UIHostingController<AnalyticsDetailYearlyScreen?>(rootView: nil)
        let rootView = AnalyticsDetailYearlyScreen()
        vc.rootView = rootView
        return vc
    }
}
