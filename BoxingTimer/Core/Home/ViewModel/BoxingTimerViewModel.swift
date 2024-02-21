//
//  BoxingTimerViewModel.swift
//  BoxingTimer
//
//  Created by ali on 21/02/2024.
//

import Foundation
import Combine

enum IntervalType {
    case workout
    case rest
}

final class TimerViewModel: ObservableObject {
    // MARK: Timer properties
    @Published var isDark:Bool = false
    @Published var showSettings:Bool = false
    @Published var intervalType: IntervalType = .workout
    @Published var timeRemaining: TimeInterval = 0
    @Published var workoutDuration: TimeInterval = 0
    @Published var restDuration: TimeInterval = 0
    @Published var totalRounds: Int = 12 // Adjusted to 12 rounds
    @Published var currentRound: Int = 1
    @Published var roundsCompleted: Int = 0
    @Published var isRunning: Bool = false
    private var timerCancellable: AnyCancellable?
    
    // MARK: Additional property for timeFormatter
    var timeFormatter: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    // MARK: Load settings from UserDefaults or set default values
    init() {
         self.workoutDuration = UserDefaults.standard.double(forKey: "workoutDuration") != 0 ? UserDefaults.standard.double(forKey: "workoutDuration") : 180
         self.restDuration = UserDefaults.standard.double(forKey: "restDuration") != 0 ? UserDefaults.standard.double(forKey: "restDuration") : 60
         self.totalRounds = UserDefaults.standard.integer(forKey: "totalRounds") != 0 ? UserDefaults.standard.integer(forKey: "totalRounds") : 15
         self.timeRemaining = self.workoutDuration
         
         // Set the initial values if it's the first time the app is launched
         if UserDefaults.standard.double(forKey: "workoutDuration") == 0 {
             UserDefaults.standard.set(workoutDuration, forKey: "workoutDuration")
         }
         if UserDefaults.standard.double(forKey: "restDuration") == 0 {
             UserDefaults.standard.set(restDuration, forKey: "restDuration")
         }
         if UserDefaults.standard.integer(forKey: "totalRounds") == 0 {
             UserDefaults.standard.set(totalRounds, forKey: "totalRounds")
         }
    }
    // MARK: - Methods
    // Start the timer
    func startTimer() {
        guard !isRunning else { return }
        isRunning = true
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .sink { _ in
                self.updateTimer()
            }
    }
    
    // Update the timer
    private func updateTimer() {
        guard timeRemaining > 0 else { return }
        timeRemaining -= 1
        if timeRemaining == 0 {
            handleIntervalEnd()
        }
    }
    
    // Reset the timer status
    func resetTimer() {
        timeRemaining = workoutDuration
        roundsCompleted = 0
        currentRound = 1
        isRunning = false
    }
    
    // Pause the timer
    func pauseTimer() {
        guard isRunning else { return }
        isRunning = false
        timerCancellable?.cancel()
    }
    
    // MARK: - private Methods
    // Handle the end of an interval (workout or rest)
    private func handleIntervalEnd() {
        switch intervalType {
        case .workout:
            startRestInterval()
        case .rest:
            startWorkoutInterval()
        }
    }
    
    // Start the rest interval
    private func startRestInterval() {
        intervalType = .rest
        timeRemaining = restDuration
        updateRoundStatus()
    }
    
    // Start the workout interval
    private func startWorkoutInterval() {
        intervalType = .workout
        timeRemaining = workoutDuration
        updateRoundStatus()
    }
    
    // Update the round status
    private func updateRoundStatus() {
        if intervalType == .workout {
            roundsCompleted += 1
            if roundsCompleted == totalRounds {
                currentRound = 1
                roundsCompleted = 0
            } else {
                currentRound += 1
            }
        }
    }
    
    // Save settings to UserDefaults
    private func saveSettingsToUserDefaults() {
        UserDefaults.standard.set(workoutDuration, forKey: "workoutDuration")
        UserDefaults.standard.set(restDuration, forKey: "restDuration")
        UserDefaults.standard.set(totalRounds, forKey: "totalRounds")
    }
   
}
