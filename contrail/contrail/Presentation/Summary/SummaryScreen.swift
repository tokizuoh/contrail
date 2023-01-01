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
                highlights
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

    private var highlights: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            SectionHeaderView("Highlights")
            // TODO
            SummaryHighlightView(type: .distance, quantity: 127.2)
            SummaryHighlightView(type: .kilocalories, quantity: 137)

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
