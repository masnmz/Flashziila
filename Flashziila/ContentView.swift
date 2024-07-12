//
//  ContentView.swift
//  Flashziila
//
//  Created by Mehmet Alp Sönmez on 12/07/2024.
//

import SwiftUI

struct ContentView: View {
   
    
    var body: some View {
        VStack {
            Text("Hello")
            
            Spacer()
                .frame(height: 100)
            
            Text("world")
        }
        .contentShape(.rect)
        .onTapGesture {
            print("Vstak is tapped")
        }
    }
}

#Preview {
    ContentView()
}
