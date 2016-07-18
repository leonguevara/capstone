//
//  QRViewController.swift
//  capstone
//
//  Created by León Felipe Guevara Chávez on 7/15/16.
//  Copyright © 2016 León Felipe Guevara Chávez. All rights reserved.
//

import UIKit
import AVFoundation

class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession : AVCaptureSession?
    var videoPreviewLayer : AVCaptureVideoPreviewLayer?
    var qrCodeFrameView : UIView?
    var urls : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize de capture session object.
            captureSession = AVCaptureSession()
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            qrCodeFrameView?.layer.borderWidth = 3
            qrCodeFrameView?.layer.borderColor = UIColor.redColor().CGColor
            view.addSubview(qrCodeFrameView!)
            view.bringSubviewToFront(qrCodeFrameView!)
            
            // Start video capture.
            captureSession?.startRunning()
        } catch {
            
        }
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            
            let alert = UIAlertController(title: "Oops", message: "No fue detectado código QR alguno", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(defaultAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
            //messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil {
                urls = metadataObj.stringValue
                performSegueWithIdentifier("qrWebSegue", sender: self)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "qrWebSegue") {
            let vc = segue.destinationViewController as! QRWebViewController
            self.captureSession?.stopRunning()
            vc.urls = self.urls
        }
    }

}
