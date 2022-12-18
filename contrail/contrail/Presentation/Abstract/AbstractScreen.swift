//
//  AbstractScreen.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import SwiftUI

struct AbstractScreen: View {
    @ObservedObject var viewModel: AbstractScreenViewModel

    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading,
                spacing: 20
            ) {
                thisYear
                thisMonth
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
        .navigationTitle("Abstract")
        .onAppear {
            viewModel.dispatch()
        }
    }

    private var thisYear: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            Text("This Year")
                .font(.title2)
                .bold()
                .padding(.horizontal, 5)
            AbstractChartView(data: viewModel.data.chartViewItem)
        }
    }

    private var thisMonth: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            HStack(alignment: .firstTextBaseline) {
                Text("Recently")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal, 5)
                Spacer()
                Button {
                    // TODO: 一覧画面に繊維
                } label: {
                    Text("Show More")
                        .foregroundColor(.brand)
                }
            }
            // TODO: 最大3件表示に変更する
            ForEach(viewModel.data.workoutItems) { item in
                WorkoutItemView(item: item)
            }
        }
    }
}
