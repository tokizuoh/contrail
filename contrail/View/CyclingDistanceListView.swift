//
//  CyclingDistanceListView.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import SwiftUI

struct CyclingDistanceListView: View {
    let cyclingDistanceList: [CyclingDistance]

    var body: some View {
        VStack {
            // TODO: [#38] リストの中に追加する
            CyclingDistanceTopView(viewModel: .init(totalCyclingDistance: "1000.23",
                                                    maxDistancePerOneRide: "45.6"))
            List(cyclingDistanceList) { cyclingDistance in
                CyclingDistanceRowView(cyclingDistance: .init(distance: cyclingDistance.distance,
                                                              date: cyclingDistance.date))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.contrailLightGray)
            }
            .listStyle(.plain)
        }
    }
}

struct CyclingDistanceListView_Previews: PreviewProvider {
    static var previews: some View {
        CyclingDistanceListView(cyclingDistanceList: [
            .init(distance: 41.1, date: "2022.05.08"),
            .init(distance: 22.4, date: "2022.05.03"),
            .init(distance: 35.1, date: "2022.04.29"),
            .init(distance: 33.3, date: "2022.04.24"),
            .init(distance: 19.2, date: "2022.04.21"),
            .init(distance: 48.5, date: "2022.04.20")
        ])
    }
}
