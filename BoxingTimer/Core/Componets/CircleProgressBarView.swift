//
//  CircleProgressBarView.swift
//  BoxingTimer
//
//  Created by ali on 21/02/2024.
//

import SwiftUI

struct CircleProgressBarView: View {
    
    let progress:CGFloat
    
    @State private var trimColor:LinearGradient = LinearGradient(colors: [Color.blue,Color.pink], startPoint: .bottomLeading, endPoint: .topTrailing)
    
    var body: some View {
        ZStack {
            backgroundCircle
            secondCircleWithTrim
        }
        .padding(30)
    }
}

#Preview {
    CircleProgressBarView(progress: 0.3)
}

extension CircleProgressBarView {
    
    private var backgroundCircle: some View {
           Circle()
               .fill(trimColor.opacity(0.2))
               .stroke(.blue.opacity(0.30), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
       }
      
    private var secondCircleWithTrim: some View {
        Circle()
            .trim(from: 0.0, to: progress)
            .stroke(trimColor, style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
            .rotationEffect(.degrees(-90))
            .shadow(color: .blue.opacity(0.5), radius: 5)
            .animation(.spring, value: progress)
    }
}
