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
    @ObservedObject var healthKitClient: HealthKitClient

    init() {
        healthKitClient = HealthKitClient.shared
    }

    var body: some View {
        CyclingDistanceListView(viewModel: .init(cyclingTopViewModel: .init(totalCyclingDistance: "1111",
                                                                            maxDistancePerOneRide: "111"),
                                                 cyclingDistanceList: healthKitClient.cyclingDistanceList))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
