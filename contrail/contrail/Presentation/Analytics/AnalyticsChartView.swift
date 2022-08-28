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
    .init(date: Date(), distance: 50),
    .init(date: Date(), distance: 12),
    .init(date: Date(), distance: 60)
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
        .frame(height: 250)
        .padding(20)
        .background(Color.darkGray)
        .cornerRadius(10)
    }
}

struct AnalyticsChartView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsChartView()
    }
}
