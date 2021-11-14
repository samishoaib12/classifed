import AVFoundation

extension AVAudioSession {
    public func isBluetoothConnected() -> Bool {
        
        let arrayInputs = AVAudioSession.sharedInstance().availableInputs
        for port in arrayInputs ?? [] {
            if port.portType == .bluetoothHFP {
                return true
            }
        }
        return false
    }
}
