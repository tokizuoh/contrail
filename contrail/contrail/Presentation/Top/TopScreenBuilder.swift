//
//  TopScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/08/14.
//

import SwiftUI

struct TopScreenBuilder {
    static func build() -> UIHostingController<TopScreen> {
        let vc = UIHostingController(rootView: TopScreen())
        return vc
    }
}
