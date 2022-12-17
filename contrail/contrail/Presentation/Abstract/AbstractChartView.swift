//
//  AbstractChartView.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import Charts
import SwiftUI

struct AbstractChartViewItem {
    let totalDistanceString: String
    let workoutItems: [AbstractChartViewWorkoutItem]
}

struct AbstractChartViewWorkoutItem: Identifiable {
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

struct AbstractChartView: View {
    let data: AbstractChartViewItem

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
                    AbstractChartViewWorkoutItem.WorkoutType.cycling.rawValue: .blue,
                    AbstractChartViewWorkoutItem.WorkoutType.running.rawValue: .green,
                    AbstractChartViewWorkoutItem.WorkoutType.walking.rawValue: .yellow
                ])
                .frame(height: 250)
            }
        }
        .padding(20)
        .background(Color.darkGray)
        .cornerRadius(10)
    }
}
