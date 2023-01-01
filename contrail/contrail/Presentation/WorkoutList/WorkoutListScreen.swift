//
//  WorkoutListScreen.swift
//  contrail
//
//  Created by tokizo on 2022/12/18.
//

import SwiftUI

struct WorkoutListScreen: View {
    @ObservedObject var viewModel: WorkoutListScreenViewModel

    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading,
                spacing: 10
            ) {
                ForEach(viewModel.data.sectionList) { section in
                    ForEach(section.itemList) { item in
                        WorkoutItemView(item: item)
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
        // TODO: 月別でセクション別にするメニューを追加
        .navigationTitle("Workouts")
        .onAppear {
            viewModel.dispatch()
        }
    }
}
