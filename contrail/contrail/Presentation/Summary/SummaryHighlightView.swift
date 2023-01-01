//
//  SummaryHighlightView.swift
//  contrail
//
//  Created by tokizo on 2023/01/01.
//

import SwiftUI

struct SummaryHighlightView: View {
    enum HighlightType {
        case distance
        case kilocalories

        var name: String {
            switch self {
            case .distance:
                return "Total Distance"
            case .kilocalories:
                return "Total Kilocalories"
            }
        }

        var degree: String {
            switch self {
            case .distance:
                return "km"
            case .kilocalories:
                return "kcal"
            }
        }
    }

    let type: HighlightType
    let quantity: Double

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            HStack(alignment: .firstTextBaseline) {
                Text(type.name)
                    .font(.subheadline)
                    .foregroundColor(.healthOrange)
                    .bold()
                Spacer()
                HStack(alignment: .center) {
                    Text("Jun 2023")
                    Image(systemName: "chevron.forward")
                }
                .foregroundColor(.lightGray)
                .font(.footnote)

            }
            HStack(
                alignment: .firstTextBaseline,
                spacing: 2
            ) {
                Text("\(quantity, specifier: "%.0f")")
                    .font(.title2)
                Text(type.degree)
                    .font(.headline)
            }
            .bold()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.darkGray)
        .cornerRadius(10)
    }
}

#if DEBUG
struct SummaryTotalKilocaloriesView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            SummaryHighlightView(type: .distance, quantity: 213.7)
            SummaryHighlightView(type: .kilocalories, quantity: 137)
        }

    }
}
#endif
