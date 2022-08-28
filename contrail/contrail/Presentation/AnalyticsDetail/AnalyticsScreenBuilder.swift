//
//  AnalyticsScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/08/28.
//

import SwiftUI

struct AnalyticsScreenBuilder {
    static func build() -> UIHostingController<AnalyticsScreen?> {
        let vc = UIHostingController<AnalyticsScreen?>(rootView: nil)
        let rootView = AnalyticsScreen()
        vc.rootView = rootView
        return vc
    }
}
