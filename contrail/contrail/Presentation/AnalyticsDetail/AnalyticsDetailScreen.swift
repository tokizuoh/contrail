//
//  AnalyticsDetailScreen.swift
//  contrail
//
//  Created by tokizo on 2022/08/28.
//

import SwiftUI

struct AnalyticsDetailScreen: View {
    @ObservedObject var viewModel = AnalyticsDetailViewModel(workoutsCacher: WorkoutsCacher.shared)

    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading
            ) {
                AnalyticsDetailChartView(data: viewModel.data.chartViewItem)
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

struct AnalyticsDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsDetailScreen()
    }
}
