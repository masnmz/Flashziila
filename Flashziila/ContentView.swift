//
//  ContentView.swift
//  Flashziila
//
//  Created by Mehmet Alp Sönmez on 12/07/2024.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
   @State private var counter = 0
    
    var body: some View {
        Text("Hello World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    cancelTimer()
                } else {
                    print("The time is now \(time)")
                    counter += 1
                }
                
                
                   
            }
    }
    
    func cancelTimer() {
        timer.upstream.connect().cancel()
    }
}

#Preview {
    ContentView()
}
