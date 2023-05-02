//
//  ScannQRManager.swift
//  ReadQR
//
//  Created by Guillermo Moral on 19/04/2023.
//

import Foundation
import AVFoundation
import UIKit

protocol ScannQRManagerDelegate: AnyObject {
    func failed()
    func found(code: String)
}

class ScannQRManager: NSObject {
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var rootVC: UIViewController?
    weak var delegate: ScannQRManagerDelegate?
    
    func setup(rootVC: UIViewController) {
        
        self.rootVC = rootVC
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let vc = self.rootVC {
            previewLayer.frame = vc.view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            vc.view.layer.addSublayer(previewLayer)
        }
        
        let backgroundQueue = DispatchQueue(label: "com.app.queue.qr", qos: .background)
        
        backgroundQueue.async {
            self.captureSession.startRunning()
        }
        
    }
    
    private func failed() {
        
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        if let vc = self.rootVC {
            vc.present(ac, animated: true)
        }
        
        captureSession = nil
    }
    
    private func found(code: String) {
        print(code)
    }
    
    public func stopRunning() {
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    public func startRunning() {
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
}

extension ScannQRManager : AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection) {
        
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            self.delegate?.found(code: stringValue)
        }
    }
}
