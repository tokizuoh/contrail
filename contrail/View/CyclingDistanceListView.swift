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
        List(cyclingDistanceList) { cyclingDistance in
            CyclingDistanceRow(distance: cyclingDistance.distance,
                               date: cyclingDistance.date)
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
            .init(distance: 48.5, date: "2022.04.20"),
        ])
    }
}
