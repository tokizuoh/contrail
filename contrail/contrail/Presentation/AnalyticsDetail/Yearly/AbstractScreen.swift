//
//  AbstractScreen.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import SwiftUI

struct AbstractScreen: View {
    @ObservedObject var viewModel = AbstractScreenViewModel(workoutsCacher: WorkoutsCacher.shared)

    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading,
                spacing: 20
            ) {
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text("This Year")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal, 5)
                    AnalyticsDetailYearlyChartView(data: viewModel.data.chartViewItem)
                }
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text("This Month")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal, 5)
                    ForEach(viewModel.data.workoutItems) { item in
                        WorkoutItemView(item: item)
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
        .navigationTitle("Abstract")
        .onAppear {
            viewModel.dispatch()
        }
    }
}
