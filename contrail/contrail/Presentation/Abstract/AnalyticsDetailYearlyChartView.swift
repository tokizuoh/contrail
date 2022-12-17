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
        case walking = "Walking"
    }
    var id = UUID()
    let type: WorkoutType
    let date: Date
    let distance: Double
}

struct AnalyticsDetailYearlyChartView: View {
    let data: AnalyticsDetailYearlyChartViewItem

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                // TODO: 共有アクション
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
            VStack(alignment: .leading) {
                VStack(
                    alignment: .leading,
                    spacing: 2
                ) {
                    Text("Total Distances")
                        .font(.subheadline)
                        .foregroundColor(.lightGray)
                    Text("\(data.totalDistanceString) KM")
                        .font(.title2)
                        .bold()
                }
                Chart {
                    ForEach(data.workoutItems) { item in
                        BarMark(
                            x: .value("Shape Type", item.date.formatted(.dateTime.month(.twoDigits))),
                            y: .value("Distance", item.distance)
                        )
                        .foregroundStyle(by: .value("Distance", item.type.rawValue))
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom) { _ in
                        AxisGridLine(centered: true)
                        AxisTick(centered: true)
                        AxisValueLabel()
                    }
                }
                .chartForegroundStyleScale([
                    AnalyticsDetailYearlyWorkoutItem.WorkoutType.cycling.rawValue: .blue,
                    AnalyticsDetailYearlyWorkoutItem.WorkoutType.running.rawValue: .green,
                    AnalyticsDetailYearlyWorkoutItem.WorkoutType.walking.rawValue: .yellow
                ])
                .frame(height: 250)
            }
        }
        
        .padding(20)
        .background(Color.darkGray)
        .cornerRadius(10)
    }
}
