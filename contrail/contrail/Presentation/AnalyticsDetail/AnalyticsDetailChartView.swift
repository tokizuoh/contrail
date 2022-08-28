//
//  AnalyticsDetailChartView.swift
//  contrail
//
//  Created by tokizo on 2022/08/28.
//

import Charts
import SwiftUI

struct AnalyticsDetailChartViewItem {
    let totalDistanceString: String
    let workoutItems: [AnalyticsDetailWorkoutItem]
}

struct AnalyticsDetailWorkoutItem: Identifiable {
    enum WorkoutType: String {
        case cycling = "Cycling"
        case running = "Running"
    }
    var id = UUID()
    let type: WorkoutType
    let date: Date
    let distance: Double
}

struct AnalyticsDetailChartView: View {
    let data: AnalyticsDetailChartViewItem

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

struct AnalyticsDetailChartView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsDetailChartView(data:
                                    .init(
                                        totalDistanceString: "",
                                        workoutItems: []
                                    )
        )
    }
}
