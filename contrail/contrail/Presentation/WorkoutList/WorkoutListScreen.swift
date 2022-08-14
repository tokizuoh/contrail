//
//  WorkoutListScreen.swift
//  contrail
//
//  Created by tokizo on 2022/08/14.
//

import SwiftUI

struct WorkoutListScreen: View {
    @ObservedObject var viewModel = WorkoutListVideModel(workoutsCacher: WorkoutsCacher.shared)

    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading,
                spacing: 5
            ) {
                ForEach(viewModel.data.workoutCellItems) { item in
                    WorkoutAbstractView(item: item)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
        }
        .navigationTitle("List")
        .onAppear {
            viewModel.dispatch()
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListScreen()
    }
}
