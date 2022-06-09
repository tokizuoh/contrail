//
//  RideStatisticsRowView.swift
//  contrail
//
//  Created by tokizo on 2022/05/14.
//

import SwiftUI
import Charts

struct RideStatisticsRowView: View {
    let rideStatistics: RideStatistics

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack(alignment: .topLeading) {
                totalDistanceChartView
                    .frame(height: 250)
                    .padding(.vertical, 12)
                totalDistanceText
                    .padding(.top, 8)
                    .foregroundColor(.contrailBrand1)
                    .padding(.bottom, 12)
            }
            maxDistanceText
            ZStack(alignment: .topLeading) {
                Text("Average Speed")
                    .font(.headline)
                    .foregroundColor(.contrailLightGray1)
                    .padding(.vertical, 12)
                totalDistanceAverageSpeedsChartView
                    .frame(height: 200)
            }

        }
    }

    // MARK: - component
    var totalDistanceChartView: some View {
        Chart(rideStatistics.cumulativeRides) {
            BarMark(
                x: .value("Date", $0.date),
                y: .value("CumulativeDistance", $0.distance)
            )
            .foregroundStyle(Color.contrailBrand1)
        }
        .chartXAxis(.hidden)
    }

    var totalDistanceAverageSpeedsChartView: some View {
        Chart(rideStatistics.averageSpeeds) {
            LineMark(
                x: .value("Date", $0.date),
                y: .value("AverageSpeed", $0.speed)
            )
            .foregroundStyle(.green)
        }
        .chartXAxis(.hidden)
    }

    var totalDistanceText: some View {
        VStack(alignment: .leading) {
            Text("Total Distance")
                .font(.headline)
                .foregroundColor(.contrailLightGray1)
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text("\(rideStatistics.totalDistanceText)")
                    .font(.title3)
                Text("km")
                    .font(.subheadline)
            }
        }
    }

    var maxDistanceText: some View {
        VStack(alignment: .leading) {
            Text("Max Distance for one ride")
                .font(.headline)
                .foregroundColor(.contrailLightGray1)
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text("\(rideStatistics.maxDistanceText)")
                    .font(.title3)
                    .foregroundColor(.contrailBrand1)
                Text("km")
                    .font(.subheadline)
                    .foregroundColor(.contrailBrand1)
                    .padding(.trailing, 8)
                Text("( \(rideStatistics.maxDistanceDate) )")
                    .font(.caption)
                    .foregroundColor(.contrailLightGray2)
            }
        }
    }
}

struct RideStatistics: ViewModelProtocol {
    struct CumulativeRide: Identifiable {
        var id = UUID()
        let date: String
        let distance: Double
    }

    struct AverageSpeed: Identifiable {
        var id = UUID()
        let date: String
        let speed: Double
    }

    let totalDistanceText: String
    let maxDistanceText: String
    let maxDistanceDate: String
    let cumulativeRides: [CumulativeRide]
    let averageSpeeds: [AverageSpeed]

    static func generateEmpty() -> RideStatistics {
        return .init(totalDistanceText: "",
                     maxDistanceText: "",
                     maxDistanceDate: "",
                     cumulativeRides: [],
                     averageSpeeds: [])
    }

    static func generateMock() -> Self {
        return .init(totalDistanceText: "1000.21",
                     maxDistanceText: "30.5",
                     maxDistanceDate: "2022.05.23",
                     cumulativeRides: [],
                     averageSpeeds: [])
    }
}

struct RideStatisticsRowView_Previews: PreviewProvider {
    static var previews: some View {
        RideStatisticsRowView(rideStatistics: RideStatistics.generateMock())
    }
}
