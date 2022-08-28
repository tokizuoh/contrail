//
//  AnalyticsChartView.swift
//  contrail
//
//  Created by tokizo on 2022/08/28.
//

import Charts
import SwiftUI

struct WorkoutHoge: Identifiable {
    var id = UUID()
    let date: Date
    let distance: Double

}

var data: [WorkoutHoge] = [
    .init(date: Date(), distance: 111),
    .init(date: Date(), distance: 12),
    .init(date: Date(), distance: 151)
]

struct AnalyticsChartView: View {
    var body: some View {
        VStack {
            Text("Total Distances")
            Chart {
                ForEach(data) { item in
                    BarMark(
                        x: .value("Shape Type", item.date),
                        y: .value("Total Count", item.distance)
                    )
                }
            }
        }
    }
}

struct AnalyticsChartView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsChartView()
    }
}
