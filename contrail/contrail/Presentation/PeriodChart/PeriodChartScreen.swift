//
//  PeriodChartScreen.swift
//  contrail
//
//  Created by tokizo on 2023/01/02.
//

import Charts
import SwiftUI

struct PeriodChartScreen: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("TODO")
            Text("TODO")
            ChartView(items: [])
            .padding(.vertical, 20)
            .frame(height: 350)
        }
        .padding(.horizontal, 24)
        .navigationTitle("Active Energy")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.darkGray)
    }
}

#if DEBUG
struct PeriodChartScreen_Previews: PreviewProvider {
    static var previews: some View {
        PeriodChartScreen()
    }
}
#endif
