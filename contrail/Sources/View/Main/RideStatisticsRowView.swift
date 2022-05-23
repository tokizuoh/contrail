//
//  RideStatisticsRowView.swift
//  contrail
//
//  Created by tokizo on 2022/05/14.
//

import SwiftUI

struct RideStatisticsRowView: View {
    let rideStatistics: RideStatistics

    var body: some View {
        VStack(alignment: .leading) {
            totalDistanceText
                .padding(.top, 8)
                .foregroundColor(.contrailBrand1)
                .padding(.bottom, 12)
            maxDistanceText
                .padding(.bottom, 8)
        }
    }

    // MARK: - component
    var totalDistanceText: some View {
        VStack(alignment: .leading) {
            Text("Total Distance")
                .font(.headline)
                .foregroundColor(.contrailLightGray1)
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text("\(rideStatistics.totalDistanceText)")
                    .font(.title3)
                Text("km")
                    .font(.subheadline)
            }
        }
    }

    var maxDistanceText: some View {
        VStack(alignment: .leading) {
            Text("Max Distance for one ride")
                .font(.headline)
                .foregroundColor(.contrailLightGray1)
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text("\(rideStatistics.maxDistancePerOneRideText)")
                    .font(.title3)
                    .foregroundColor(.contrailBrand1)
                Text("km")
                    .font(.subheadline)
                    .foregroundColor(.contrailBrand1)
                    .padding(.trailing, 4)
                Text("(2022.06.22)")
                    .font(.caption)
                    .foregroundColor(.contrailLightGray2)

            }
        }
    }
}

struct RideStatistics: ViewModelProtocol {
    let totalDistanceText: String
    let maxDistancePerOneRideText: String

    static func generateEmpty() -> RideStatistics {
        return .init(totalDistanceText: "",
                     maxDistancePerOneRideText: "")
    }

    static func generateMock() -> Self {
        return .init(totalDistanceText: "1000.21",
                     maxDistancePerOneRideText: "30.5")
    }
}

struct RideStatisticsRowView_Previews: PreviewProvider {
    static var previews: some View {
        RideStatisticsRowView(rideStatistics: RideStatistics.generateMock())
    }
}
