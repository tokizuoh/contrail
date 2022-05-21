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
        RideListView(rideList: viewModel.data)
            .onAppear {
                Task {
                    await viewModel.fetch()
                }
            }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
