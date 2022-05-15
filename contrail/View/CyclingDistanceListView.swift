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
            CyclingDistanceTopView(viewModel: viewModel.cyclingTopViewModel)
            List(viewModel.cyclingDistanceRowViewModels) { cyclingDistanceRowViewModel in
                RideRowView(viewModel: cyclingDistanceRowViewModel)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.contrailLightGray)
            }
            .listStyle(.plain)
        }
    }
}

struct CyclingDistanceListViewModel: ViewModelProtocol {
    let cyclingTopViewModel: CyclingDistanceTopViewModel
    let cyclingDistanceRowViewModels: [CyclingDistanceRowViewModel]

    static func generateEmpty() -> Self {
        return .init(cyclingTopViewModel: .generateEmpty(),
                     cyclingDistanceRowViewModels: [.generateEmpty()])
    }

    static func generateMock() -> Self {
        let cyclingTopViewModel: CyclingDistanceTopViewModel = .init(totalCyclingDistanceText: "1000.23",
                                                                     maxDistancePerOneRideText: "45.6")
        let cyclingDistanceRowViewModels: [CyclingDistanceRowViewModel] = [
            .init(distanceText: "41.1", dateText: "2022.05.08"),
            .init(distanceText: "22.4", dateText: "2022.05.03"),
            .init(distanceText: "35.1", dateText: "2022.04.29"),
            .init(distanceText: "33.3", dateText: "2022.04.24"),
            .init(distanceText: "19.2", dateText: "2022.04.21"),
            .init(distanceText: "48.5", dateText: "2022.04.20")
        ]
        return .init(cyclingTopViewModel: cyclingTopViewModel,
                     cyclingDistanceRowViewModels: cyclingDistanceRowViewModels)
    }
}

struct CyclingDistanceListView_Previews: PreviewProvider {
    static var previews: some View {
        CyclingDistanceListView(viewModel: CyclingDistanceListViewModel.generateMock())
    }
}
