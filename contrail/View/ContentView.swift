//
//  ContentView.swift
//  contrail
//
//  Created by tokizo on 2022/05/07.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    // TODO: [#30] HealthKitClient の命名を考え直す
    @ObservedObject var viewModel = ContentViewModel()

    //    init() {
    //        healthKitClient = HealthKitClient.shared
    //    }

    var body: some View {
        CyclingDistanceListView(viewModel: viewModel.data)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
