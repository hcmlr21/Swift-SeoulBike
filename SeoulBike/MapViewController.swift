//
//  MapViewController.swift
//  SeoulBike
//
//  Created by Jkookoo on 2020/08/21.
//  Copyright © 2020 Jkookoo. All rights reserved.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {
    // MARK: - ProPerties
    let apiKey = "52516b6f6768636d38306848616a70"
    var bikeDatas: [BikeDataModel.RentBikeStatus] = []
    let mapKey = "eMUPmNaPhsvBdc3GWGnMlsbA0a0oDKKcUVGK9ZB7"
    
    
    // MARK: - Methods
    func getBikeData() {
        var startIndex = 1
        var endIndex = 1000
        while(endIndex < 4000) {
            let urlString = "http://openapi.seoul.go.kr:8088/\(self.apiKey)/json/bikeList/\(startIndex)/\(endIndex)/"
            guard let url = URL(string: urlString) else {
                print("url 실패")
                return
            }
            
            print("url 성공")
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if(error == nil) {
                    let jsonDecoder = JSONDecoder()
                    do {
                        print("디코딩중...")
                        let bikeData = try jsonDecoder.decode(BikeDataModel.self, from: data!)
                        if let bikeStatus = bikeData.rentBikeStatus {
                            self.bikeDatas.append(bikeStatus)
                        }
                        
                        if endIndex >= 4000 {
                            self.mapConfig()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("url error : " + error.debugDescription)
                }
            }
            dataTask.resume()
            startIndex += 1000
            endIndex += 1000
        }
    }

    
    func mapConfig() {
        DispatchQueue.main.async {
            self.naverMapView.showCompass = true
            self.naverMapView.showLocationButton = true
            self.naverMapView.showZoomControls = true
        }
        
        let mapView = naverMapView.mapView
        //좌표
        let marker = NMFMarker()
        
        for page in self.bikeDatas {
            for row in page.rows! {
                let lat = row.stationLatitude
                let lng = row.stationLongitude
                if let doubleLat = Double(lat!), let doubleLng = Double(lng!) {
                    let coord = NMGLatLng(lat: doubleLat, lng: doubleLng)
                    
                    DispatchQueue.main.async {
                        mapView.latitude = doubleLat
                        mapView.longitude = doubleLng
                        marker.position = coord
                        
                        marker.mapView = mapView
                    }
                }
            }
        }
        
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    
    // MARK: - IBActions
    
    // MARK: - Delegates And DataSource
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBikeData()
        
    }
}
