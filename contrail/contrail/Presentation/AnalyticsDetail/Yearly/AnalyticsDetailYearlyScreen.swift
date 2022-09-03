//
//  AnalyticsDetailYearlyScreen.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import SwiftUI

struct AnalyticsDetailYearlyScreen: View {
    @ObservedObject var viewModel = AnalyticsDetailYearlyViewModel(workoutsCacher: WorkoutsCacher.shared)

    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading
            ) {
                AnalyticsDetailYearlyChartView(data: viewModel.data.chartViewItem)
                // TODO: ボタン: 何かしらのAverage
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
        }
        .navigationTitle("Analytics")
        .onAppear {
            viewModel.dispatch()
        }
    }
}
