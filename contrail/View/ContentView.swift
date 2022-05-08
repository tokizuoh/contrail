//
//  ContentView.swift
//  contrail
//
//  Created by tokizo on 2022/05/07.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        let _ = HealthKitClient()
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
