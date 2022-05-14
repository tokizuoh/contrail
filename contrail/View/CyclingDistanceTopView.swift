//
//  CyclingDistanceTopView.swift
//  contrail
//
//  Created by tokizo on 2022/05/14.
//

import SwiftUI

struct CyclingDistanceTopView: View {
    let viewModel: CyclingDistanceTopViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Distance")
                .font(.headline)
                .padding(.top, 8)
                .padding(.horizontal, 16)
            Text("\(viewModel.totalCyclingDistance) km")
                .font(.body)
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            Text("Maximum Distance for one ride")
                .font(.headline)
                .padding(.horizontal, 16)
            Text("\(viewModel.maxDistancePerOneRide) km")
                .font(.body)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
        }
        .background(Color.contrailLightGray)
        .cornerRadius(8)
    }
}

struct CyclingDistanceTopViewModel {
    let totalCyclingDistance: String
    let maxDistancePerOneRide: String
}

struct CyclingDistanceTotalView_Previews: PreviewProvider {
    static var previews: some View {
        CyclingDistanceTopView(viewModel: .init(totalCyclingDistance: "1000.21",
                                                maxDistancePerOneRide: "30.5"))
    }
}
