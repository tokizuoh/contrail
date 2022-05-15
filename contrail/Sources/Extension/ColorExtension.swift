//
//  ColorExtension.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import SwiftUI

extension Color {
    private static let limit: Double = 255

    static let contrailLightGray1 = Color.init(red: 245/limit, green: 245/limit, blue: 245/limit)
    static let contrailLightGray2 = Color.init(red: 230/limit, green: 230/limit, blue: 230/limit)
    static let contrailDarkGray = Color.init(red: 100/limit, green: 100/limit, blue: 100/limit)
    static let contrailBrand1 = Color.init(red: 0/limit, green: 213/limit, blue: 255/limit)
    static let contrailBrand2 = Color.init(red: 0/limit, green: 170/limit, blue: 204/limit)
}
