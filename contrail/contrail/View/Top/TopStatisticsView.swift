//
//  TopStatisticsView.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import SwiftUI

struct TopStatisticsItem {
    let allTotalDistanceText: String
    let maxDistanceText: String
    let thisMonthTotalDistanceText: String
}

struct TopStatisticsView: View {
    let item: TopStatisticsItem

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text("All Total")
                    .font(.title2)
                HStack(alignment: .bottom) {
                    Text(item.allTotalDistanceText)
                        .font(.title)
                    Text("km")
                        .font(.subheadline)
                }
                .foregroundColor(.brand)
                .padding(.vertical, 10)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Max Distance")
                    .font(.title2)
                HStack(alignment: .bottom) {
                    Text(item.maxDistanceText)
                        .font(.title)
                    Text("km")
                        .font(.subheadline)
                }
                .foregroundColor(.brand)
                .padding(.vertical, 10)
            }

        }
        .background(Color.darkGray)
        .cornerRadius(10)
        
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .padding(.horizontal, 10)

    }
}

struct TopStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        TopStatisticsView(
            item: .init(
                allTotalDistanceText: "1234",
                maxDistanceText: "56",
                thisMonthTotalDistanceText: "78"
            )
        )
    }
}
