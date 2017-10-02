//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Florian Middendorf on 10.09.17.
//  Copyright © 2017 Florian Middendorf. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
 
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateIsEnabledForButtons(false)
    }
    
    func setLabelStatus(_ statusText : String) {
        recordingLabel.text = statusText
    }
    
    func updateIsEnabledForButtons(_ isRecording : Bool){
        startRecordingButton.isEnabled = !isRecording
        stopRecordingButton.isEnabled = isRecording
        
        if isRecording
        {
            setLabelStatus("Recording in Progress")
        }else
        {
            setLabelStatus("Tap to Recording")
        }
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        updateIsEnabledForButtons(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    @IBAction func stopRecordingAudio(_ sender: Any) {
        updateIsEnabledForButtons(false)
        audioRecorder.stop();
        let audioSssion = AVAudioSession.sharedInstance()
        try! audioSssion.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag
        {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"
        {
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recordAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordAudioURL
        }
    }
}

    
