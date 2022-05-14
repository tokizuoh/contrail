//
//  CyclingDistanceRowView.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import SwiftUI

struct CyclingDistanceRowView: View {
    let viewModel: CyclingDistanceRowViewModel

    var body: some View {
        HStack(alignment: .bottom) {
            Text(viewModel.distanceText)
                .font(.title)
                .padding(EdgeInsets(top: 5,
                                    leading: 20,
                                    bottom: 5,
                                    trailing: 0))
            Spacer()
            Text(viewModel.dateText)
                .font(.subheadline)
                .foregroundColor(.contrailDarkGray)
                .padding(EdgeInsets(top: 5,
                                    leading: 0,
                                    bottom: 5,
                                    trailing: 20))
        }
        .background(.white)
        .cornerRadius(8)
    }
}

struct CyclingDistanceRowViewModel: ViewModelProtocol, Identifiable {
    var id = UUID()

    let distanceText: String
    let dateText: String

    static func generateEmpty() -> CyclingDistanceRowViewModel {
        return .init(distanceText: "",
                     dateText: "")
    }

    static func generateMock() -> CyclingDistanceRowViewModel {
        return .init(distanceText: "12.3 km",
                     dateText: "2222.11.3")
    }
}

struct CyclingDistanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        CyclingDistanceRowView(viewModel: .generateMock())
    }
}
