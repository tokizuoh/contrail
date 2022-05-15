//
//  MainCyclingView.swift
//  contrail
//
//  Created by tokizo on 2022/05/07.
//

import SwiftUI
import HealthKit

struct MainCyclingView: View {
    @ObservedObject var viewModel = MainCyclingViewModel()

    var body: some View {
        CyclingDistanceListView(viewModel: viewModel.data)
    }
}

struct MainCyclingView_Previews: PreviewProvider {
    static var previews: some View {
        MainCyclingView()
    }
}
