//
//  AudioEngineManager.swift
//  SwifTune
//
//  Created by Tim Pokanai on 2024-10-21.
//

import AVFoundation

class AudioEngineManager {
    // "var" for variables
    private var audioEngine = AVAudioEngine()
    
    func startAudioEngine(onAudioBuffer: @escaping (AVAudioPCMBuffer) -> Void) {
        // "let" for constants
        let inputNode = audioEngine.inputNode
        let inputFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) { buffer, when in onAudioBuffer(buffer)
        }
        
        try? AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: [.defaultToSpeaker])
        try? AVAudioSession.sharedInstance().setActive(true)
        try? audioEngine.start()
    }
    
    func stopAudioEngine() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
}
