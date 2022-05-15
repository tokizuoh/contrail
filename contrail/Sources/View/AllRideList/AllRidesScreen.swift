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
                    .listRowSeparator(.hidden)
            }
            .navigationTitle("all rides")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

struct AllRideRowView: View {
    let rideDetail: RideDetail

    var body: some View {
        HStack {
            // TODO: [#67] デザイン考える
            Text(rideDetail.durationText)
            Text(rideDetail.dateText)
            Text(rideDetail.distanceText)
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
