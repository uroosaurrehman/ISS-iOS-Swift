//
//  ISSPositionModel.swift
//  ISSLive
//
//  Created by Uroosa on 07/22/22.
//

import Foundation

///  This struct models the ISS position API response.
class ISSPositionModel {
    let position: ISSPosition

    init (dict: [String:AnyObject]) {

        let model = ISSPosition(dict["iss_position"] as? [String:AnyObject] ?? [String:AnyObject]())
        position = model
    }
}

struct ISSPosition: Codable {
    let longitude: String
    let latitude: String

    init (_ dict: [String:AnyObject]) {
        self.longitude = dict["longitude"] as? String ?? ""
        self.latitude = dict["latitude"] as? String ?? ""
    }
}
