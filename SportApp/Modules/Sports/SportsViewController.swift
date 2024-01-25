//
//  SportsViewController.swift
//  SportApp
//
//  Created by Menna Setait on 25/01/2024.
//

import UIKit

class SportsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewLayout {
    
    
    var url:[URL]=[]

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url1 = URL(string: "https://www.pngitem.com/pimgs/m/49-491826_of-course-developing-your-employee-%20engagement-offering-business.png")
        let url2 = URL(string: "https://images.pexels.com/photos/39853/woman-girl-freedom-happy-39853.jpeg?auto=compress&cs=tinysrgb&w=600")
        let url3 = URL(string: "https://www.pngitem.com/pimgs/m/49-491826_of-course-developing-your-employee-%20engagement-offering-business.png")
        let url4 = URL(string: "https://www.pngitem.com/pimgs/m/49-491826_of-course-developing-your-employee-%20engagement-offering-business.png")
        let url5 = URL(string: "https://images.pexels.com/photos/1462011/pexels-photo-1462011.jpeg?auto=compress&cs=tinysrgb&w=600")
        url.append(url1!)
        url.append(url2!)
        url.append(url3!)
        url.append(url4!)
        url.append(url5!)
        
        
    }
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportCollectionViewCell
        
                do{
                    let data = try Data(contentsOf : url[indexPath.row])
                    cell.imgOutlet.image = UIImage(data: data)
                }catch{
                }
        return cell
    }
    // MARK: - Collection View Layout
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width=(( UIScreen.main.bounds.size.width)/2)
        let height=(( UIScreen.main.bounds.size.width)/2)
        return CGSize(width: width, height: height)
        
    }
    
//    func configureTabViewLayout(appearance:AppearanceStyle)->UICollectionViewLayout{
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .vertical
//        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
//        let viewWidth = view.frame.width
//        let width = (appearance == .list) ? (viewWidth - 36) : viewWidth * 0.46
//        flowLayout.itemSize = .init(width: width, height: 175)
//        return flowLayout
//        
//    }
    
    // MARK: - Collection View Configuration
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: K.customNibTapSports, bundle: nil), forCellWithReuseIdentifier: K.customNibTapSports)
        
//        let layout = configureTabViewLayout
//        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }


   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
