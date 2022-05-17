//
//  AllRideRowView.swift
//  contrail
//
//  Created by tokizo on 2022/05/15.
//

import SwiftUI

struct AllRideRowView: View {
    let rideDetail: RideDetail

    var body: some View {
        VStack {
            distanceComponent
            Divider()
                .padding(.bottom, 4)
            HStack {
                totalTimeComponent
                Spacer()
            }
            Spacer()
        }
    }

    // MARK: - component
    var distanceComponent: some View {
        HStack(alignment: .lastTextBaseline) {
            HStack(alignment: .lastTextBaseline) {
                Text(rideDetail.distanceText)
                    .font(.title)
                Text("km")
                    .font(.subheadline)
            }
            .foregroundColor(.contrailBrand1)
            .padding(.vertical, 5)

            Spacer()

            Text(rideDetail.dateText)
                .font(.subheadline)
                .foregroundColor(.contrailLightGray2)
                .padding(.vertical, 5)
        }
    }

    var totalTimeComponent: some View {
        VStack(alignment: .leading) {
            Text("Total Time")
                .font(.subheadline)
                .foregroundColor(.contrailLightGray2)
            Text(rideDetail.durationText)
                .font(.title2)
                .foregroundColor(.contrailBrand2)
        }
    }

    var averageSpeedComponent: some View {
        VStack(alignment: .leading) {
            Text("Total Time")
                .font(.subheadline)
                .foregroundColor(.contrailLightGray2)
            Text(rideDetail.averageSpeedText)
                .font(.title2)
                .foregroundColor(.contrailBrand2)
        }
    }
}

struct AllRideRowView_Previews: PreviewProvider {
    static var previews: some View {
        AllRideRowView(rideDetail: .generateMock())
    }
}
