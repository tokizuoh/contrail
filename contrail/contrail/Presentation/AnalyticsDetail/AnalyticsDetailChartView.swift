//
//  AnalyticsDetailChartView.swift
//  contrail
//
//  Created by tokizo on 2022/08/28.
//

import Charts
import SwiftUI

struct AnalyticsDetailWorkoutItem: Identifiable {
    // TODO: タイプ？
    var id = UUID()
    let date: Date
    let distance: Double

}

struct AnalyticsDetailChartView: View {
    let workoutItems: [AnalyticsDetailWorkoutItem]

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
                ForEach(workoutItems) { item in
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
        AnalyticsDetailChartView(workoutItems: [])
    }
}
