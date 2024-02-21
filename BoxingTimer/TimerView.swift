//
//  ContentView.swift
//  BoxingTimer
//
//  Created by giasIOS on 21/02/2024.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject private var vm:TimerViewModel
    @State private var animated:Bool = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    TimerView()
        .environmentObject(TimerViewModel())
}


// MARK: Extensinon for Timer View
extension TimerView {
    
    private var statusWorkout: some View {
        Text(vm.intervalType == .workout ? "Boxing" : "Rest time")
            .font(.system(size: 38, weight: .semibold, design: .rounded))
            .foregroundStyle(.primary)
    }
    
    private var currentRoundWithRoundCount: some View {
        Text("\(vm.currentRound)/\(vm.totalRounds)")
            .font(.system(size: 44, weight: .semibold, design: .rounded))
            .foregroundStyle(.primary)
        
    }
}
