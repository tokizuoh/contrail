//
//  SectionHeaderView.swift
//  contrail
//
//  Created by tokizo on 2022/12/24.
//

import SwiftUI

struct SectionHeaderView: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
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
