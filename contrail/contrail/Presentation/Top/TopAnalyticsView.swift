//
//  TopAnalyticsView.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import SwiftUI

struct TopAnalyticsItem {
    let allTotalDistanceText: String
    let maxDistanceText: String
    let thisMonthTotalDistanceText: String
}

struct TopAnalyticsView: View {
    let item: TopAnalyticsItem

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ComponentView(
                title: "All",
                amount: item.allTotalDistanceText
            )
            ComponentView(
                title: "Max",
                amount: item.maxDistanceText
            )
            ComponentView(
                title: "This Month",
                amount: item.thisMonthTotalDistanceText
            )
        }
        .padding(.all, 10)
        .background(Color.darkGray)
        .cornerRadius(10)
    }

}

private struct ComponentView: View {
    let title: String
    let amount: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(title)
                    .font(.title3)
                Spacer()
            }
            HStack(alignment: .bottom) {
                Text(amount)
                    .font(.title)
                Text("km")
                    .font(.subheadline)
            }
            .foregroundColor(.brand)
        }
    }
}

struct TopAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        TopAnalyticsView(
            item: .init(
                allTotalDistanceText: "1234",
                maxDistanceText: "56",
                thisMonthTotalDistanceText: "78"
            )
        )
    }
}
