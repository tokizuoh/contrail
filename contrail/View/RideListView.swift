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
        List {
            Section {
                RideAggregationRowView(rideAggregation: rideList.rideAggregation)
            }
            Section {
                LazyVStack {
                    ForEach(rideList.rides) { ride in
                        RideRowView(ride: ride)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.contrailLightGray)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct RideList: ViewModelProtocol {
    let rideAggregation: RideAggregation
    let rides: [Ride]

    static func generateEmpty() -> Self {
        return .init(rideAggregation: .generateEmpty(),
                     rides: [.generateEmpty()])
    }

    static func generateMock() -> Self {
        let rideAggregation: RideAggregation = .init(totalDistanceText: "1000.23",
                                                     maxDistancePerOneRideText: "45.6")
        let rides: [Ride] = [
            .init(distanceText: "41.1", dateText: "2022.05.08"),
            .init(distanceText: "22.4", dateText: "2022.05.03"),
            .init(distanceText: "35.1", dateText: "2022.04.29"),
            .init(distanceText: "33.3", dateText: "2022.04.24"),
            .init(distanceText: "19.2", dateText: "2022.04.21"),
            .init(distanceText: "48.5", dateText: "2022.04.20")
        ]
        return .init(rideAggregation: rideAggregation,
                     rides: rides)
    }
}

struct RideListView_Previews: PreviewProvider {
    static var previews: some View {
        RideListView(rideList: RideList.generateMock())
    }
}
