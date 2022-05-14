//
//  CyclingDistanceListView.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import SwiftUI

struct CyclingDistanceListView: View {
    let viewModel: CyclingDistanceListViewModel

    var body: some View {
        VStack {
            // TODO: [#38] リストの中に追加する
            CyclingDistanceTopView(viewModel: .init(totalCyclingDistance: "1000.23",
                                                    maxDistancePerOneRide: "45.6"))
            List(viewModel.cyclingDistanceList) { cyclingDistance in
                CyclingDistanceRowView(cyclingDistance: .init(distance: cyclingDistance.distance,
                                                              date: cyclingDistance.date))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.contrailLightGray)
            }
            .listStyle(.plain)
        }
    }
}

struct CyclingDistanceListViewModel {
    let cyclingTopViewModel: CyclingDistanceTopViewModel
    let cyclingDistanceList: [CyclingDistance]

    static func generateMock() -> Self {
        let cyclingTopViewModel: CyclingDistanceTopViewModel = .init(totalCyclingDistance: "1000.23",
                                                                     maxDistancePerOneRide: "45.6")
        let cyclingDistanceList: [CyclingDistance] = [
            .init(distance: 41.1, date: "2022.05.08"),
            .init(distance: 22.4, date: "2022.05.03"),
            .init(distance: 35.1, date: "2022.04.29"),
            .init(distance: 33.3, date: "2022.04.24"),
            .init(distance: 19.2, date: "2022.04.21"),
            .init(distance: 48.5, date: "2022.04.20")
        ]
        return .init(cyclingTopViewModel: cyclingTopViewModel,
                     cyclingDistanceList: cyclingDistanceList)
    }
}

struct CyclingDistanceListView_Previews: PreviewProvider {
    static var previews: some View {
        CyclingDistanceListView(viewModel: CyclingDistanceListViewModel.generateMock())
    }
}
