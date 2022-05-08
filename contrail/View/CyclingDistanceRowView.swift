//
//  CyclingDistanceRowView.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import SwiftUI

struct CyclingDistanceRowView: View {
    let distance: Double
    let date: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("\(distance.description) km")
                .font(.title)
                .padding(EdgeInsets(top: 5,
                                    leading: 20,
                                    bottom: 5,
                                    trailing: 0))
            Spacer()
            Text(date)
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

struct CyclingDistanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        CyclingDistanceRowView(distance: 41.456,
                               date: "2022.05.08")
    }
}
