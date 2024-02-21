//
//  ClockView.swift
//  BoxingTimer
//
//  Created by ali on 21/02/2024.
//

import SwiftUI

struct ClockView: View {
    
    let format: String
    @Binding var animated:Bool
    
    var body: some View {
        Text(format)
            .font(.system(size: 128, weight: .thin, design: .rounded))
            .multilineTextAlignment(.center)
            .foregroundStyle(.primary)
            .scaleEffect(animated ? 1.08 : 1)
            .frame(maxWidth: .infinity)
            .frame(height: 105)
    }
}

#Preview {
    ClockView(format: "00:00", animated: .constant(false))
}
