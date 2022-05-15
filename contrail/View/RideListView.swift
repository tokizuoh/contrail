//
//  RideListView.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import SwiftUI

struct RideListView: View {
    let rideList: RideList

    var body: some View {
        VStack {
            // TODO: [#38] リストの中に追加する
            RideAggregationRowView(viewModel: rideList.cyclingTopViewModel)
            List(rideList.cyclingDistanceRowViewModels) { cyclingDistanceRowViewModel in
                RideRowView(ride: cyclingDistanceRowViewModel)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.contrailLightGray)
            }
            .listStyle(.plain)
        }
    }
}

struct RideList: ViewModelProtocol {
    let cyclingTopViewModel: CyclingDistanceTopViewModel
    let cyclingDistanceRowViewModels: [Ride]

    static func generateEmpty() -> Self {
        return .init(cyclingTopViewModel: .generateEmpty(),
                     cyclingDistanceRowViewModels: [.generateEmpty()])
    }

    static func generateMock() -> Self {
        let cyclingTopViewModel: CyclingDistanceTopViewModel = .init(totalCyclingDistanceText: "1000.23",
                                                                     maxDistancePerOneRideText: "45.6")
        let cyclingDistanceRowViewModels: [Ride] = [
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
        RideListView(rideList: RideList.generateMock())
    }
}
