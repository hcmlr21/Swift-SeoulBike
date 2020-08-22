//
//  BikeDataModel.swift
//  SeoulBike
//
//  Created by Jkookoo on 2020/08/21.
//  Copyright © 2020 Jkookoo. All rights reserved.
//
/*
 {
 "rentBikeStatus":
 {
     "list_total_count":5,
     "RESULT":{"CODE":"INFO-000","MESSAGE":"정상 처리되었습니다."},
     "row":[
  {"rackTotCnt":"22","stationName":"102. 망원역 1번출구 앞","parkingBikeTotCnt":"3","shared":"0","stationLatitude":"37.55564880","stationLongitude":"126.91062927","stationId":"ST-4"},
  {"rackTotCnt":"16","stationName":"103. 망원역 2번출구 앞","parkingBikeTotCnt":"1","shared":"0","stationLatitude":"37.55495071","stationLongitude":"126.91083527","stationId":"ST-5"},
  {"rackTotCnt":"15","stationName":"104. 합정역 1번출구 앞","parkingBikeTotCnt":"4","shared":"0","stationLatitude":"37.55062866","stationLongitude":"126.91498566","stationId":"ST-6"},
  {"rackTotCnt":"7","stationName":"105. 합정역 5번출구 앞","parkingBikeTotCnt":"2","shared":"0","stationLatitude":"37.55000687","stationLongitude":"126.91482544","stationId":"ST-7"},
  {"rackTotCnt":"12","stationName":"106. 합정역 7번출구 앞","parkingBikeTotCnt":"7","shared":"0","stationLatitude":"37.54864502","stationLongitude":"126.91282654","stationId":"ST-8"}]}}
 */
 



import Foundation

struct BikeDataModel: Codable {
    var rentBikeStatus: RentBikeStatus?
    
    struct RentBikeStatus: Codable {
        var listTotalCount: Int?
        var result: Result?
        var rows: [Row]?
        
        struct Result: Codable {
            var code: String?
            var message: String?
            
            enum CodingKeys: String, CodingKey {
                case code = "CODE"
                case message = "MESSAGE"
            }
        }
        
        struct Row: Codable {
            var rackTotCnt: String?
            var stationName: String?
            var parkingBikeTotCnt: String?
            var shared: String?
            var stationLatitude: String?
            var stationLongitude: String?
            var stationId: String?
        }
        
        enum CodingKeys: String, CodingKey {
            case result = "RESULT"
            case rows = "row"
            case listTotalCount = "list_total_count"
        }
    }
}
