//
//  SettingsView.swift
//  BoxingTimer
//
//  Created by ali on 21/02/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var vm:TimerViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Boxing ").font(.headline)) {
                    Stepper(value: $vm.totalRounds, in: 1...100) {
                        Text("Total Rounds: ")
                            .fontWeight(.semibold) +
                        Text("\(vm.totalRounds)")
                            .font(.title3)
                    }
                    Stepper(value: $vm.workoutDuration, in: 60...3600, step: 60) {
                        Text("Round Duration:")
                            .fontWeight(.semibold) +
                        Text(" \(Int(vm.workoutDuration) / 60) min")
                            .font(.title3)
                    }
                    
                    Stepper(value: $vm.restDuration, in: 30...600, step: 30) {
                        Text("Rest Duration:")
                            .fontWeight(.semibold) +
                        Text(" \(Int(vm.restDuration) / 60) min")
                            .font(.title3)
                    }
                }
                
                Section(header: Text("Mode").font(.headline)) {
                   
                    Toggle(isOn: $vm.isDark) {
                        Text(vm.isDark ? "Light" : "Dark Mode")
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Done")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .onTapGesture {
                            dismiss()
                            vm.resetTimer()
                        }
                }
            }
        }
        .preferredColorScheme(vm.isDark ? .dark : .light)
        .listRowSpacing(10)
        .font(.subheadline)
    }
}

#Preview {
    SettingsView()
        .environmentObject(TimerViewModel())
}
