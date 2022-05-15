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
        NavigationView {
            contentView
                .navigationTitle("contrail")
        }
    }

    // MARK: - component
    var contentView: some View {
        List {
            rideStatisticsSection
            ridesSection
        }
    }

    var rideStatisticsSection: some View {
        Section(content: {
            RideStatisticsRowView(rideStatistics: rideList.rideStatistics)
        }, header: {
            Text("Statistics")
                .font(.headline)
        })
    }

    var ridesSection: some View {
        Section(content: {
            ForEach(rideList.rides) { ride in
                RideRowView(ride: ride)
                    .listRowSeparator(.hidden)
            }
        }, header: {
            HStack(alignment: .lastTextBaseline) {
                Text("Rides")
                    .font(.headline)
                Spacer()
                NavigationLink(destination: AllRidesScreen()) {
                    Image(systemName: "arrowtriangle.right.fill")
                        .foregroundColor(.contrailBrand)
                }
            }
        })
    }
}

struct RideList: ViewModelProtocol {
    let rideStatistics: RideStatistics
    let rides: [Ride]

    static func generateEmpty() -> Self {
        return .init(rideStatistics: .generateEmpty(),
                     rides: [.generateEmpty()])
    }

    static func generateMock() -> Self {
        let rideStatistics: RideStatistics = .init(totalDistanceText: "1000.23",
                                                   maxDistancePerOneRideText: "45.6")
        let rides: [Ride] = [
            .init(distanceText: "41.1", dateText: "2022.05.08"),
            .init(distanceText: "22.4", dateText: "2022.05.03"),
            .init(distanceText: "35.1", dateText: "2022.04.29"),
            .init(distanceText: "33.3", dateText: "2022.04.24"),
            .init(distanceText: "19.2", dateText: "2022.04.21"),
            .init(distanceText: "48.5", dateText: "2022.04.20")
        ]
        return .init(rideStatistics: rideStatistics,
                     rides: rides)
    }
}

struct RideListView_Previews: PreviewProvider {
    static var previews: some View {
        RideListView(rideList: RideList.generateMock())
    }
}
