//
//  MainScreen.swift
//  contrail
//
//  Created by tokizo on 2022/05/07.
//

import SwiftUI
import HealthKit

struct MainScreen: View {
    @ObservedObject var viewModel = MainViewModel()

    var body: some View {
        CyclingDistanceListView(viewModel: viewModel.data)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
