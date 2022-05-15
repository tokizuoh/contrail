//
//  AllRidesScreen.swift
//  contrail
//
//  Created by tokizo on 2022/05/15.
//

import SwiftUI

struct AllRidesScreen: View {
    @ObservedObject var viewModel = AllRidesViewModel()

    var body: some View {
        List {
            ForEach(viewModel.data) { item in
                AllRideRowView(rideDetail: item)
                    .listRowSeparator(.visible)
            }
            .navigationTitle("all rides")
            .navigationBarTitleDisplayMode(.inline)
        }.environment(\.defaultMinListRowHeight, 250)
    }
}

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

struct AllRidesScreen_Previews: PreviewProvider {
    static var previews: some View {
        AllRidesScreen()
    }
}

struct RideDetail: ViewModelProtocol, Identifiable {
    var id = UUID()

    let distanceText: String
    let dateText: String
    let durationText: String

    static func generateEmpty() -> RideDetail {
        return .init(distanceText: "",
                     dateText: "",
                     durationText: "")
    }

    static func generateMock() -> RideDetail {
        return .init(distanceText: "10.3",
                     dateText: "2222.11.3",
                     durationText: "xx:xx - xx:xx")
    }
}