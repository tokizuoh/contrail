//
//  SummaryScreen.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import SwiftUI

struct SummaryScreen: View {
    @ObservedObject var viewModel: SummaryScreenViewModel

    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading,
                spacing: 20
            ) {
                thisYear
                recently
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
        .navigationTitle("Summary")
        .onAppear {
            viewModel.dispatch()
        }
    }

    private var thisYear: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            SectionHeaderView("This Year")
            SummaryChartView(data: viewModel.data.chartViewItem)
        }
    }

    private var recently: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            HStack(alignment: .firstTextBaseline) {
                SectionHeaderView("Recently")
                Spacer()
                Button("Show More") {
                    viewModel.routeToWorkoutListScreen()
                }
            }
            ForEach(viewModel.data.workoutItems) { item in
                WorkoutItemView(item: item)
            }
        }
    }
}