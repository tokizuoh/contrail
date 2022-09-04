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
                alignment: .leading,
                spacing: 20
            ) {
                AnalyticsDetailYearlyChartView(data: viewModel.data.chartViewItem)
                // 今月のワークアウトセル
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text("This month")
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 5)
                    ForEach(viewModel.data.workoutItems) { item in
                        WorkoutItemView(item: item)
                    }
                }
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
