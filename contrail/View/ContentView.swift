//
//  ContentView.swift
//  contrail
//
//  Created by tokizo on 2022/05/07.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @ObservedObject var healthKitClient: HealthKitClient
    
    init() {
        healthKitClient = HealthKitClient.shared
    }
    
    var body: some View {
        CyclingDistanceListView(cyclingDistanceList: healthKitClient.cyclingDistanceList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
