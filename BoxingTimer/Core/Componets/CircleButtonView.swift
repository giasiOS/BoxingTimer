//
//  CircleButtonView.swift
//  BoxingTimer
//
//  Created by ali on 21/02/2024.
//

import SwiftUI

struct CircleButtonView: View {
    @State private var animate:Bool = false
    var style:ButtonStyle
    var body: some View {
        
       startButtonStyle
            .onAppear {
                withAnimation(.bouncy(duration: 2).repeatForever()) {
                    animate.toggle()
                }
            }
    }
}

#Preview {
    CircleButtonView(style: .start)
}

extension CircleButtonView {
    
    private var startButtonStyle:some View {
        ZStack {
            Circle()
                .fill(style.fill)
                .frame(width: 88, height: 88)
            Circle()
                .fill(.white)
                .frame(width: 84, height: 84)
                
            Text(style.title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(style.tintColor)
                .frame(width: 80, height: 80)
                .background(style.fill)
                .clipShape(Circle())
                
                .shadow(color:shodowColor(), radius: 5, x: 0, y: 0)
        }
        .scaleEffect(animate ? 1.04 : 1)
    }
    
    func shodowColor() -> Color {
        switch style {
        case .start:
            return .green.opacity(0.5)
        case .pause:
            return .pink.opacity(0.5)
        case .reset:
            return .gray.opacity(0.5)
        }
    }
   
    // ENUM
    enum ButtonStyle {
        
        case start, pause, reset
        
        var title:String {
            switch self {
            case .start:
                return "Start".uppercased()
            case .pause:
                return "Pause".uppercased()
            case .reset:
                return "Reset".uppercased()
            }
        }
        
        var fill:Color {
            switch self {
            case .start:
                return Color(.systemGreen)
            case .pause:
                return Color(.systemOrange)
            case .reset:
                return Color(.secondarySystemBackground)
            }
        }
        
        var tintColor: Color {
            switch self {
            case .start:
                return .primary
            case .pause:
                return .primary
            case .reset:
                return .secondary
            }
        }
    }
}
