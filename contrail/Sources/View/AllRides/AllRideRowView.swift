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
            HStack(alignment: .lastTextBaseline) {
                HStack(alignment: .lastTextBaseline) {
                    Text(rideDetail.distanceText)
                        .font(.title)
                    Text("km")
                        .font(.subheadline)
                }
                .foregroundColor(.contrailBrand)
                .padding(.vertical, 5)

                Spacer()

                Text(rideDetail.dateText)
                    .font(.subheadline)
                    .foregroundColor(.contrailLightGray2)
                    .padding(.vertical, 5)
            }
            Divider()
                .padding(.bottom, 4)

            Text(rideDetail.durationText)
            Spacer()
        }
    }
}

struct AllRideRowView_Previews: PreviewProvider {
    static var previews: some View {
        AllRideRowView(rideDetail: .generateMock())
    }
}
