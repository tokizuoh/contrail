//
//  PeriodChartScreen.swift
//  contrail
//
//  Created by tokizo on 2023/01/02.
//

import Charts
import SwiftUI

struct PeriodChartScreen: View {
    @ObservedObject
    var viewModel = PeriodChartScreenViewModel(workoutsCacher: WorkoutsCacher.shared)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("TODO")
                Text("TODO")
                ChartView(items: viewModel.data.chartItems)
                    .padding(.vertical, 20)
                    .frame(height: 350)
            }
            .padding(.horizontal, 24)
            .background(Color.darkGray)
        }
        .navigationTitle("Active Energy")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: viewModel.dispatch)
    }
}

#if DEBUG
struct PeriodChartScreen_Previews: PreviewProvider {
    static var previews: some View {
        PeriodChartScreen()
    }
}
#endif
