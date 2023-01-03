//
//  SummaryHighlightView.swift
//  contrail
//
//  Created by tokizo on 2023/01/01.
//

import SwiftUI

enum HighlightType {
    case distance
    case kilocalories

    var degree: String {
        switch self {
        case .distance:
            return "km"
        case .kilocalories:
            return "kcal"
        }
    }

    // ここでcolorをもたせるのは責務として良くなさそう？
    var color: Color {
        switch self {
        case .distance:
            return .healthBlue
        case .kilocalories:
            return .healthRed
        }
    }
}

struct HighlightItem: Identifiable {
    let type: HighlightType
    let date: Date
    let quantity: Double

    var id: HighlightType {
        return type
    }
}

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    return dateFormatter
}()

struct SummaryHighlightView: View {
    let item: HighlightItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(
                alignment: .leading,
                spacing: 8
            ) {
                HStack(alignment: .firstTextBaseline) {
                    headlineText
                        .font(.subheadline)
                        .foregroundColor(item.type.color)
                        .bold()
                    Spacer()
                    HStack(alignment: .center) {
                        Text(item.date, formatter: dateFormatter)
                        Image(systemName: "chevron.forward")
                    }
                    .foregroundColor(.lightGray1)
                    .font(.footnote)

                }
                HStack(
                    alignment: .firstTextBaseline,
                    spacing: 2
                ) {
                    Text("\(item.quantity, specifier: "%.0f")")
                        .font(.title2)
                    Text(item.type.degree)
                        .font(.headline)
                }
                .bold()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.darkGray)
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }

    private var headlineText: some View {
        switch item.type {
        case .distance:
            return Text("Total Distance")
        case .kilocalories:
            return Text("Total Kilocalories")
        }
    }
}

#if DEBUG
struct SummaryTotalKilocaloriesView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            SummaryHighlightView(
                item: HighlightItem(
                    type: .distance,
                    date: Date(),
                    quantity: 213.7
                ),
                action: {}
            )
            SummaryHighlightView(
                item: HighlightItem(
                    type: .distance,
                    date: Date(),
                    quantity: 137
                ),
                action: {}
            )
        }
    }
}
#endif
