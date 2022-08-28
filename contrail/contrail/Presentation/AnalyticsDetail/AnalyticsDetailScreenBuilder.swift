//
//  AnalyticsDetailScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/08/28.
//

import SwiftUI

struct AnalyticsDetailScreenBuilder {
    static func build() -> UIHostingController<AnalyticsDetailScreen?> {
        let vc = UIHostingController<AnalyticsDetailScreen?>(rootView: nil)
        let rootView = AnalyticsDetailScreen()
        vc.rootView = rootView
        return vc
    }
}
