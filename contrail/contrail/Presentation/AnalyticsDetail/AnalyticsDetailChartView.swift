//
//  AnalyticsDetailChartView.swift
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

struct AnalyticsDetailChartView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(
                alignment: .leading,
                spacing: 2
            ) {
                Text("Total Distances")
                    .font(.subheadline)
                    .foregroundColor(.lightGray)
                Text("150.3 km")
                    .font(.title3)
                    .bold()
            }
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

struct AnalyticsDetailChartView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsDetailChartView()
    }
}
