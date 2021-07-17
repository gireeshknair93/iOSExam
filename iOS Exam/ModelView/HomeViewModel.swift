//
//  HomeViewModel.swift
//  iOS Exam
//
//  Created by Gireesh on 16/07/21.
//

import UIKit

class HomeViewModel{
    
    var controller:HomeViewController!
    var model:HomeModel!
    
    init(controller:HomeViewController) {
        self.controller = controller
        self.controller.homeListTable.register(UINib(nibName: "ImageListTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.HomeView.imageListCell)
        self.controller.homeListTable.register(UINib(nibName: "ContentListTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.HomeView.contentListCell)
        self.controller.homeListTable.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.HomeView.searchCell)
        model = HomeModel()
        model.reloadMainTable = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                // TableView ReloadData
                controller.homeListTable.reloadData()
            }
        }
        model.reloadSubList = {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                // TableView ReloadData
                controller.homeListTable.reloadSections([1,2], with: .none)
            }
        }
    }
    func getNumberOfMainList()->Int{
        return model.collegeInfo?.homeList.count ?? 0
    }
    func getMainListModelFor(index:Int)->HomeListModel?{
        return model.collegeInfo?.homeList[index]
    }
    func getsubListCount(index:Int)->Int{
        return model.filteredSubList?.count ?? 0
    }
    func getSubListModel(mainIndex:Int,subIndex:Int)->HomeSubList?{
        if (model.filteredSubList?.count ?? 0) > subIndex{
            return model.filteredSubList?[subIndex]
        }
        return nil
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
        }else if section == 2{
            return viewModel.getsubListCount(index: viewModel.model.selectedMainIndex)
        }
        
        return Constants.HomeView.defaultCellCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            return 50
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.HomeView.imageListCell) as! ImageListTableViewCell
            cell.cellData = viewModel.model.collegeInfo?.homeList
            cell.delegate = self
            cell.mainIndex = viewModel.model.selectedMainIndex
            return cell

        }else if indexPath.section == 1{
            //Seaerch cell here
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.HomeView.searchCell) as! SearchTableViewCell
            cell.delegate = self
            cell.searchTxt.text = ""
                return cell

        }else{
            //List cell here
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.HomeView.contentListCell) as! ContentListTableViewCell
            cell.loadDataOnCell(model: viewModel.getSubListModel(mainIndex: viewModel.model.selectedMainIndex, subIndex: indexPath.row))
                return cell
        }
        
        return UITableViewCell.init()
    }
}
extension HomeViewController:CollectionScrollDelegate,SearchDelegate{
    func cellIndexChanged(index: Int) {
        viewModel.model.selectedMainIndex = index
    }
    func searchTextChanged(text: String) {
        if let currentSubList = viewModel.model.collegeInfo?.homeList[viewModel.model.selectedMainIndex].subList{
            if text == ""{
                viewModel.model.filteredSubList = currentSubList
            }else{
                viewModel.model.filteredSubList = currentSubList.filter({ (list) -> Bool in
                    return "\(list.title ?? "")".lowercased().contains(text.lowercased())
                })
            }
            
            self.homeListTable.reloadSections([2], with: .none)
        }
    }
}
