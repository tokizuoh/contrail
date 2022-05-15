//
//  MainView.swift
//  contrail
//
//  Created by tokizo on 2022/05/07.
//

import SwiftUI
import HealthKit

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()

    var body: some View {
        CyclingDistanceListView(viewModel: viewModel.data)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
