//
//  ImageListTableViewCell.swift
//  iOS Exam
//
//  Created by Gireesh on 16/07/21.
//

import UIKit
protocol CollectionScrollDelegate {
    func cellIndexChanged(index:Int)
}
class ImageListTableViewCell: UITableViewCell {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var mainIndex = 0
    var delegate:CollectionScrollDelegate?
    var cellData:[HomeListModel]?{
        didSet{
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.HomeView.imageCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //[self.calendarView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        //[self setAutomaticallyAdjustsScrollViewInsets:NO];
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ImageListTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = cellData?.count ?? 0
        return cellData?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.HomeView.imageCell, for: indexPath) as! ImageCollectionViewCell
        
        cell.loader.isHidden = false
        cell.loader.startAnimating()
        cell.imageView.image = nil
        cell.imageView.contentMode = .scaleToFill
        if let model = cellData?[indexPath.row]{
            
            if let url = URL.init(string: model.image ?? ""){
                let image = ImageCache.shared.getImage(url: (model.image ?? "") as AnyObject)
                if image != nil{
                    cell.imageView.image = image
                    cell.loader.stopAnimating()
                }else{
                    DispatchQueue.global(qos: .userInteractive).async {
                        
                            if let data = try? Data(contentsOf: url) {
                                // Create Image and Update Image View
                                DispatchQueue.main.async {
                                    if let imageDownloaded = UIImage(data: data){
                                        cell.imageView.image = imageDownloaded
                                        cell.loader.stopAnimating()
                                        ImageCache.shared.saveImage(image: imageDownloaded, forUrl: (model.image ?? "") as AnyObject)
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                }
            
            
        }
        
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Method 1")
        let index = Int(self.collectionView.contentOffset.x / self.collectionView.frame.size.width)
        //if let index = index {
            if mainIndex != index{
                delegate?.cellIndexChanged(index: index)
                mainIndex = index
            }
            pageControl.currentPage = index
        //}
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("Method 2")
        
    }
}
extension ImageListTableViewCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
