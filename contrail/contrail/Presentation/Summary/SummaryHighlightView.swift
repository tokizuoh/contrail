//
//  SummaryHighlightView.swift
//  contrail
//
//  Created by tokizo on 2023/01/01.
//

import SwiftUI

struct HighlightItem: Identifiable {
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
                    Text(item.type.name)
                        .font(.subheadline)
                        .foregroundColor(.healthOrange)
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
