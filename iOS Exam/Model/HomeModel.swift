//
//  HomeModel.swift
//  iOS Exam
//
//  Created by Gireesh on 16/07/21.
//

import Foundation
class HomeModel{
    var reloadMainTable: (() -> ())?
    var reloadSubList:(() -> ())?
    var selectedMainIndex:Int = 0{
        didSet{
            filteredSubList = collegeInfo?.homeList[selectedMainIndex].subList
            self.reloadSubList?()
        }
    }
    var collegeInfo:HomeDataModel?{
        didSet{
            filteredSubList = collegeInfo?.homeList[selectedMainIndex].subList
            self.reloadMainTable?()
        }
    }
    var filteredSubList:[HomeSubList]? = [HomeSubList]()
    init() {
        Network().getMockList { [weak self] (success, response, error) in
            guard let self = self else { return }
            if success == ResponseCode.success {
                guard let response = response else {
                    return
                }
                self.collegeInfo = response as? HomeDataModel
                
            } else {
            }
        }
    }
}
struct HomeDataModel: Decodable{
    var homeList:[HomeListModel]
}
struct HomeListModel: Decodable {
    var image:String?
    var subList: [HomeSubList]?
}
struct HomeSubList: Decodable {
    var title: String?
}
