//
//  BoxingTimerApp.swift
//  BoxingTimer
//
//  Created by ali on 21/02/2024.
//

import SwiftUI

@main
struct BoxingTimerApp: App {
    @StateObject private var vm = BoxingTimerViewModel()
    var body: some Scene {
        WindowGroup {
            TimerView()
                .environmentObject(vm)
        }
    }
}
