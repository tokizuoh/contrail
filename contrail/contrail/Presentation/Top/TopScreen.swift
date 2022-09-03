//
//  TopScreen.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import SwiftUI

struct TopScreen: View {
    @ObservedObject var viewModel = TopViewModel(workoutsCacher: WorkoutsCacher.shared)
    let showAnalyticsScreenAction: () -> Void
    let showAnalyticsYearlyScreenAction: () -> Void
    let showWorkoutListScreenAction: () -> Void

    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 20
            ) {
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    HStack {
                        Text("Analytics")
                            .font(.title)
                            .bold()
                            .padding(.horizontal, 5)
                        Spacer()
                        Button("Show More") {
                            //                            showAnalyticsScreenAction()
                            showAnalyticsYearlyScreenAction()
                        }
                        .foregroundColor(.brand)

                    }
                    TopAnalyticsView(item: viewModel.data.topAnalyticsItem)
                }
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    HStack(alignment: .lastTextBaseline) {
                        Text("List")
                            .font(.title)
                            .bold()
                            .padding(.horizontal, 5)
                        Spacer()
                        Button("Show More") {
                            showWorkoutListScreenAction()
                        }
                        .foregroundColor(.brand)
                    }
                    LazyVStack(
                        alignment: .leading,
                        spacing: 5
                    ) {
                        ForEach(viewModel.data.workoutCellItems) { item in
                            WorkoutAbstractView(item: item)
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
        }
        .navigationTitle("Abstract")
        .onAppear {
            viewModel.dispatch()
        }
    }
}
