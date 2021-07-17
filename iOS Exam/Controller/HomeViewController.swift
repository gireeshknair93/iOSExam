//
//  HomeViewController.swift
//  iOS Exam
//
//  Created by Gireesh on 16/07/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeListTable: UITableView!
    var viewModel:HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = HomeViewModel.init(controller: self)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
