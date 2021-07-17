//
//  HomeViewModel.swift
//  iOS Exam
//
//  Created by Gireesh on 16/07/21.
//

import UIKit

class HomeViewModel{
    
    var controller:HomeViewController!
    
    init(controller:HomeViewController) {
        self.controller = controller
        self.controller.homeListTable.register(UINib(nibName: "ImageListTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.HomeView.imageListCell)
    }
    
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }
        
        return Constants.HomeView.defaultCellCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.HomeView.imageListCell) as! ImageListTableViewCell
            return cell

        }else if indexPath.section == 1{
            //Seaerch cell here
        }else{
            //List cell here
        }
        
        return UITableViewCell.init()
    }
}
