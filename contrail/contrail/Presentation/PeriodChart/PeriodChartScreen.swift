//
//  PeriodChartScreen.swift
//  contrail
//
//  Created by tokizo on 2023/01/02.
//

import Charts
import SwiftUI

struct PeriodChartScreen: View {
    @ObservedObject var viewModel: PeriodChartScreenViewModel
    let type: HighlightType

    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 12
            ) {
                texts
                ChartView(type: type, items: viewModel.data.chartItem.items)
                    .frame(height: 250)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 24)
            .background(Color.darkGray)
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: viewModel.dispatch)
    }

    private var texts: some View {
        VStack(
            alignment: .leading,
            spacing: 4
        ) {
            Text("TOTAL")
                .font(.subheadline)
                .foregroundColor(.lightGray2)
            HStack(
                alignment: .firstTextBaseline,
                spacing: 4
            ) {
                Text("\(viewModel.data.chartItem.total, specifier: "%.1f")")
                    .font(.title)
                Text(type.degree)
                    .font(.subheadline)
                    .foregroundColor(.lightGray2)
            }
        }
        .bold()
    }

    private var navigationTitle: String {
        switch type {
        case .distance:
            return "Distance"
        case .kilocalories:
            return "Active Energy"
        }
    }
}
