//
//  ViewController.swift
//  SeoulBike
//
//  Created by Jkookoo on 2020/08/21.
//  Copyright © 2020 Jkookoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - ProPerties
    let apiKey = "52516b6f6768636d38306848616a70"
    var bikeDatas: [BikeDataModel.RentBikeStatus] = []
    
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
    
    // MARK: - IBOutlets
    
    // MARK: - IBActions
    
    // MARK: - Delegates And DataSource
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBikeData()
    }
}
