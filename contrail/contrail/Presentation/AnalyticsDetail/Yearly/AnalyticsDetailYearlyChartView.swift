//
//  AnalyticsDetailYearlyChartView.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import Charts
import SwiftUI

struct AnalyticsDetailYearlyChartViewItem {
    let totalDistanceString: String
    let workoutItems: [AnalyticsDetailYearlyWorkoutItem]
}

struct AnalyticsDetailYearlyWorkoutItem: Identifiable {
    enum WorkoutType: String {
        case cycling = "Cycling"
        case running = "Running"
    }
    var id = UUID()
    let type: WorkoutType
    let date: Date
    let distance: Double
}

struct AnalyticsDetailYearlyChartView: View {
    let data: AnalyticsDetailYearlyChartViewItem

    var body: some View {
        VStack(alignment: .leading) {
            VStack(
                alignment: .leading,
                spacing: 2
            ) {
                Text("Total Distances")
                    .font(.subheadline)
                    .foregroundColor(.lightGray)
                Text("\(data.totalDistanceString) km")
                    .font(.title3)
                    .bold()
            }
            Chart {
                ForEach(data.workoutItems) { item in
                    BarMark(
                        x: .value("Shape Type", item.date),
                        y: .value("Total Count", item.distance)
                    )
                    .foregroundStyle(by: .value("Workout Type", item.type.rawValue))
                }
            }
        }
        .frame(height: 250)
        .padding(20)
        .background(Color.darkGray)
        .cornerRadius(10)
    }
}
