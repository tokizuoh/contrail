//
//  ColorExtension.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import SwiftUI

extension Color {
    private static let limit: Double = 255
    
    static let contrailLightGray = Color.init(red: 230/limit, green: 230/limit, blue: 230/limit)
    static let contrailDarkGray = Color.init(red: 100/limit, green: 100/limit, blue: 100/limit)
}
