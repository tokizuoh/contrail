//
//  TopScreen.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import SwiftUI

struct TopScreen: View {
    @ObservedObject var viewModel = TopViewModel(workoutsCacher: WorkoutsCacher.shared)

    var body: some View {
        ScrollView {
            Button("DISPATCH APOLLO") {
                viewModel.uploadWorkout()
            }

            VStack(
                alignment: .leading,
                spacing: 20
            ) {
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text("Statistics")
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 5)
                    TopStatisticsView(item: viewModel.data.topStatisticsItem)
                }
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text("List")
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 5)
                    LazyVStack(
                        alignment: .leading,
                        spacing: 5
                    ) {
                        ForEach(viewModel.data.workoutCellItems) { item in
                            TopWorkoutCell(item: item)
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .navigationTitle("Abstract")
        .onAppear {
            viewModel.dispatch()
        }
    }
}

struct TopScreen_Previews: PreviewProvider {
    static var previews: some View {
        TopScreen()
    }
}
