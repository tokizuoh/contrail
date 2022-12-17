//
//  AbstractScreenBuilder.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import SwiftUI

struct AbstractScreenBuilder {
    static func build() -> UIHostingController<AbstractScreen?> {
        let vc = UIHostingController<AbstractScreen?>(rootView: nil)
        let rootView = AbstractScreen()
        vc.rootView = rootView
        return vc
    }
}
