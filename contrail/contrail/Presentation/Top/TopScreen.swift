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
                        Text("Statistics")
                            .font(.title)
                            .bold()
                            .padding(.horizontal, 5)
                        Spacer()
                        Button("Show More") {
                            showAnalyticsScreenAction()
                        }
                        .foregroundColor(.brand)

                    }
                    TopStatisticsView(item: viewModel.data.topStatisticsItem)
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

struct TopScreen_Previews: PreviewProvider {
    static var previews: some View {
        TopScreen(
            showAnalyticsScreenAction: {},
            showWorkoutListScreenAction: {}
        )
    }
}
