//
//  SportsViewController.swift
//  SportApp
//
//  Created by Menna Setait on 25/01/2024.
//
//imageview.kf.setimag(URL)
import UIKit
enum AppearanceStyle{
    case grid
    case list
    
    var selectedAppearance:UIImage?{
        switch self{
        case .grid : return UIImage(systemName: "square.grid.2x2")
        case .list : return UIImage(systemName: "list.bullet")
        }
    }
}

class SportsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - SportsViewController Outlets
    
    var appearanceStyleButton:UIBarButtonItem?
    var appearanceStyle:AppearanceStyle = .list
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: -Handel Will Appear VC
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = K.sportGame
        navigationController?.topViewController?.navigationItem.rightBarButtonItem?.isHidden = false
        
    }
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.setupTabViewStyle()
        
        
    }
    
    // MARK: - Collection View Configuration
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: K.customNibTapSports, bundle: nil), forCellWithReuseIdentifier: K.customNibTapSports)
        
        let layout = configureTabViewLayout(appearance: appearanceStyle)
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    // MARK: - Appearance Style Setup
    func setupTabViewStyle(){
        
        appearanceStyleButton = UIBarButtonItem(image: appearanceStyle.selectedAppearance, style: .plain, target: self, action: #selector(twistStyleOfTabCollection))
        
        navigationController?.topViewController?.navigationItem.rightBarButtonItem = appearanceStyleButton
        navigationController?.navigationBar.tintColor = .red
    }
    
    @objc func twistStyleOfTabCollection(){
        
        appearanceStyle = (appearanceStyle == .list) ? .grid : .list
        let layout = configureTabViewLayout(appearance: appearanceStyle)
        collectionView.setCollectionViewLayout(layout, animated: true)
        appearanceStyleButton?.image = appearanceStyle.selectedAppearance
    }

    
    func configureTabViewLayout(appearance:AppearanceStyle)->UICollectionViewLayout{
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        /*- 36*/
        //let viewWidth = view.frame.width
        let viewWidth = UIScreen.main.bounds.width
        let width = (appearance == .list) ? (viewWidth * 0.9) : viewWidth * 0.4
        flowLayout.itemSize = .init(width: width, height: 195)
        return flowLayout
        
    }
    

   
    // MARK: - Collection View Data Source and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return K.sports.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.customNibTapSports , for: indexPath) as! SportsCollectionViewCell
        let labelText =  K.sports[indexPath.item % K.sports.count]
        let imageName =  K.sports[indexPath.item % K.sports.count]
        //let imageName = K.sportsImg[indexPath.item % K.sportsImg.count]
        cell.configure(with: imageName , titleText: labelText)
        return cell
    }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let league = self.storyboard?.instantiateViewController(identifier: "leguesVC") as! AllLeaguesViewController
        league.sportType = K.sports[indexPath.item % K.sports.count].lowercased()
        self.navigationController?.pushViewController(league, animated: true)
        
        
    }
    

}
