//
//  RideAggregationRowView.swift
//  contrail
//
//  Created by tokizo on 2022/05/14.
//

import SwiftUI

struct RideAggregationRowView: View {
    let viewModel: CyclingDistanceTopViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Distance")
                .font(.headline)
                .padding(.top, 8)
                .padding(.horizontal, 16)
            Text("\(viewModel.totalCyclingDistanceText) km")
                .font(.body)
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            Text("Maximum Distance for one ride")
                .font(.headline)
                .padding(.horizontal, 16)
            Text("\(viewModel.maxDistancePerOneRideText) km")
                .font(.body)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
        }
        .background(Color.contrailLightGray)
        .cornerRadius(8)
    }
}

struct CyclingDistanceTopViewModel: ViewModelProtocol {
    let totalCyclingDistanceText: String
    let maxDistancePerOneRideText: String

    static func generateEmpty() -> CyclingDistanceTopViewModel {
        return .init(totalCyclingDistanceText: "",
                     maxDistancePerOneRideText: "")
    }

    static func generateMock() -> Self {
        return .init(totalCyclingDistanceText: "1000.21",
                     maxDistancePerOneRideText: "30.5")
    }
}

struct RideAggregationRowView_Previews: PreviewProvider {
    static var previews: some View {
        RideAggregationRowView(viewModel: CyclingDistanceTopViewModel.generateMock())
    }
}
