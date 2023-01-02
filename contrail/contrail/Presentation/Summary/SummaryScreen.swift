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
            LazyVStack(
                alignment: .leading,
                spacing: 10
            ) {
                ForEach(viewModel.data.highlightItems) { item in
                    SummaryHighlightView(item: item) {
                        switch item.type {
                        case .distance:
                            break
                        case .kilocalories:
                            break
                        }
                    }
                }
            }
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
