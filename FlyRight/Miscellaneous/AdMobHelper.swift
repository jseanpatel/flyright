//
//  AdMobHelper.swift
//  FlyRight
//
//  Created by Jacob Patel on 7/14/18.
//  Copyright © 2018 Jacob Patel. All rights reserved.
//

import GoogleMobileAds

let interstitialAdUnitID = "ca-app-pub-3940256099942544/4411468910"

class AdMobHelper {
    
    var interstitial: GADInterstitial!
    
    init() {
        interstitial = createAndLoadInterstitial()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: interstitialAdUnitID)
        interstitial.delegate = self as! GADInterstitialDelegate
        interstitial.load(GADRequest())
        return interstitial
    }
    
    //currently unused
    func createRequest() -> GADRequest {
        let request = GADRequest()
        request.testDevices = ["Check this in your logs"]
        return request
    }
    
    func showAd(vc: UIViewController) {
        // Check if ad should be shown
        print("here")
        if interstitial == nil {
            print("Interstitial does not exist")
            // In case the disableAd was called
            interstitial = createAndLoadInterstitial()
        } else {
            // Present the AdMob ad, if available
            if interstitial.isReady {
                interstitial!.present(fromRootViewController: vc)
                interstitial = createAndLoadInterstitial()
            } else {
                print("Interstitial is not ready")
            }
        }
    }
}
