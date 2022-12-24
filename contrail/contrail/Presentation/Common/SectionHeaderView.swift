//
//  SectionHeaderView.swift
//  contrail
//
//  Created by tokizo on 2022/12/24.
//

import SwiftUI

struct SectionHeaderView: View {
    let headerTitle: String

    init(_ headerTitle: String) {
        self.headerTitle = headerTitle
    }

    var body: some View {
        Text(headerTitle)
            .font(.title2)
            .bold()
            .padding(.horizontal, 5)
    }
}

#if DEBUG
struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView("Header Title")
    }
}
#endif
