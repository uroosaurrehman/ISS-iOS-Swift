//
//  ISSPositionViewModel.swift
//  iOSDemo
//
//  Created by Uroosa on 07/22/22.
//

import Foundation
import os

///  Makes requests to the api, it returns the current location of the ISS.
///  It returns the current latitude and longitude of the space station
///  with a unix timestamp for the time the location was valid. This API takes no inputs.
///  Then, notifies the view through binding, in order to update the UI data.
protocol ISSPositionDelegate {
    func getPosition(latitude: Double, longitude: Double)
}

final class ISSPositionViewModel {
   
    var delegate: ISSPositionDelegate?
    var networkModel = NetworkManager()

    init() {
        makeRequest()
    }
    
    func makeRequest() {

        let responseString = networkModel.getDataFrom(URL_issLocation)

        if responseString != "" {
            if let responce = responseString.toJSON() as? [String:AnyObject] {
                let model = ISSPositionModel(dict: responce)

                if let lat = Double(model.position.latitude),
                   let lon = Double(model.position.longitude) {
                    self.delegate?.getPosition(latitude: lat, longitude: lon)
                }
            }

        }

    }
}
