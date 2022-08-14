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
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListScreen()
    }
}
