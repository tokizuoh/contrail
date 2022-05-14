//
//  ContentView.swift
//  contrail
//
//  Created by tokizo on 2022/05/07.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {
        CyclingDistanceListView(viewModel: viewModel.data)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
