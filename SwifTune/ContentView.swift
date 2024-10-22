//
//  ContentView.swift
//  SwifTune
//
//  Created by Tim Pokanai on 2024-10-14.
//

import SwiftUI
import AudioKit
import AudioKitEX
import AVFoundation

class TunerViewModel: ObservableObject {
    private let audioEngine = AudioEngine()
    private var mic: AudioEngine.InputNode!
    private var fft: FFTTap!
    
    @Published var detectedFrequency: Double = 82.41
    @Published var isTuning: Bool = false
    
    init() {
        setupTuner()
    }
    
    func setupTuner() {
        mic = audioEngine.input!
        
        fft = FFTTap(mic) {
            fftData in DispatchQueue.main.async {
                if let frequency = self.getDominantFrequency(fftData: fftData) {
                    self.detectedFrequency = frequency
                }
            }
        }
        do {
            try audioEngine.start()
            fft.start()
            self.isTuning = true
        } catch {
            print("Error starting Audio Engine")
        }
    }
    
    func getDominantFrequency(fftData: [Float]) -> Double? {
        // This method will hold the logic for obtaining the dominant frequeny from a sample
        return nil
    }
}

struct ContentView: View {
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
    ContentView()
}
