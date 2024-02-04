//
//  LeagueDeatilsVC.swift
//  SportApp
//
//  Created by Menna Setait on 01/02/2024.
//

import UIKit

class LeagueDeatilsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Variables Declaration
    
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var bindResultToViewController: (() -> Void)?
    var viewModel : LeagueDetailsViewModel?
    var sportType : String?
    var sportId : Int?
    var leagueDetailsViewModel : LeagueDetailsViewModel?
    var latestViewModel : LatestEventsViewModel?
    var indicator : UIActivityIndicatorView?
    var upcomingEvents : [Event]?
    var latestEvents : [Event]?
    var networking : NetworkServiceDelegate?
    var letestNetworking : NetworkServiceDelegate?
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setIndicator()
        configureCollectionView()
        configureLoadingUpcomingEvents()
        configureLoadingLatestEvents()
        myCollectionView.collectionViewLayout = createCompositionalLayout()
        registerCollectionViewByCell()
        

    }
    
    @IBAction func backBarButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    //MARK: - Indicator initializing
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
    
    }
    
    func configureLoadingUpcomingEvents(){
        networking = NetworkServices(setUrl: HandelURL(sportType: sportType!, leagueIdWithUpcomiingEvent: sportId! ))
        print("load.000")
        viewModel = LeagueDetailsViewModel(upcomingNetworkHandler: networking)
        print("load.00")
        viewModel?.getEventsFromApi()
        print("load.11")
        viewModel?.bindResultToViewController = { [weak self] in
            print("load.22")
            DispatchQueue.main.async {
                print("load.33")
                self?.upcomingEvents = self?.viewModel?.getUpcomingEventArray()
                print(self?.upcomingEvents?[0].event_home_team)
                print("dispatchQueue")
                self?.indicator?.stopAnimating()
                self?.myCollectionView.reloadData()
            }
        }
    }
    
    func configureLoadingLatestEvents(){
        letestNetworking = NetworkServices(setUrl: HandelURL(sportType: sportType!, leagueIdWithUpcomiingEvent: sportId! ))
        print("load.000")
        latestViewModel = LatestEventsViewModel(latestNetworkHandler: letestNetworking)
        print("load.00")
        latestViewModel?.getDataFromApi()
        print("load.11")
        latestViewModel?.bindResultToViewController = { [weak self] in
            print("load.22")
            DispatchQueue.main.async {
                print("load.33")
                self?.latestEvents = self?.latestViewModel?.getLatestEventsArray()
                print(self?.latestEvents?[0].event_home_team)
                print("dispatchQueue")
                self?.indicator?.stopAnimating()
                self?.myCollectionView.reloadData()
            }
        }
    }
    
    //MARK: - Register the Nib Cells
    
    func registerCollectionViewByCell(){
        
        self.myCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: K.leaguesCollectionView)
        
        myCollectionView.register(UINib(nibName: K.customNibEvent, bundle: nil), forCellWithReuseIdentifier: K.customNibEvent)
        
        myCollectionView.register(UINib(nibName: K.customNibLatestEvent, bundle: nil), forCellWithReuseIdentifier: K.customNibLatestEvent)
        
        myCollectionView.register(UINib(nibName: K.customNibTeams, bundle: nil), forCellWithReuseIdentifier: K.customNibTeams)
        
        myCollectionView.register(UINib(nibName: K.customNibHeaderView, bundle: nil), forSupplementaryViewOfKind: K.forSupplementaryViewOfKind, withReuseIdentifier: K.customNibHeaderView)
    }
    
    
    // MARK: - CollectionView Configuration
    func configureCollectionView(){
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
    }
    
    // MARK: - Drawing First section
    func drawTheTopSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 8, bottom: 8, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
        items.forEach { item in
        let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
        let minScale: CGFloat = 0.8
        let maxScale: CGFloat = 1.5
        let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
        item.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        }
        
        return section
    }
    
    // MARK: - Drawing Second section
    func drawTheUpcommingSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
        
    }
    
    // MARK: - Drawing Third section
    func drawTeamsSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 16, bottom: 16, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
        items.forEach { item in
        let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
        let minScale: CGFloat = 0.8
        let maxScale: CGFloat = 1.0
        let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
        item.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        }
        
        return section
    }
    
    
    // MARK: - CollectionView Layout
    func createSectionFor( index:Int , environment : NSCollectionLayoutEnvironment)-> NSCollectionLayoutSection{
        
        switch index {
        case 0 :
            return     drawTheTopSection()
        case 1 :
            return     drawTheUpcommingSection()
        case 2 :
            return     drawTeamsSection()
        default :
            return     drawTeamsSection()
        }
    }
    
    func createCompositionalLayout()-> UICollectionViewCompositionalLayout  {
        let layout = UICollectionViewCompositionalLayout { [weak self] (index , enviroment) -> NSCollectionLayoutSection? in
            return self?.createSectionFor(index: index, environment: enviroment)
        }
        return layout
    }
    
    
    // MARK: - CollectionView data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return upcomingEvents?.count ?? 0
        case 1:
            return latestEvents?.count ?? 0
        case 2:
            return 10
        
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section{
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.customNibEvent, for: indexPath) as! UpcommingEventNibCell
            if let upcommingEvent = upcomingEvents?[indexPath.row]{
                cell.configureupCommingEventCell(upCommingEvent: upcommingEvent)
                        }
            return cell
            
        case 1 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.customNibLatestEvent, for: indexPath) as! LatestEventsNibCell
            if let latestEvent = latestEvents?[indexPath.row] {
                cell.configurelatestEventCell(latestEvent: latestEvent)
            }
            return cell
            
        case 2 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.customNibTeams, for: indexPath) as! TeamDetailsNibCell
            //            if let team = team[indexPath.row]{
            //                cell.configure(team: team)
            //            }
            
            return cell
            
        default :
            return UICollectionViewCell()
        }
    }
    
    
    
    
    // MARK: - Setting Header of each section
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let view = myCollectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: K.customNibHeaderView , for: indexPath) as? HeaderNibCell else{
            return UICollectionReusableView()
        }
        
        
        switch indexPath.section {
        case 0 :
            view.title = K.upCommingEventHeader
            return view

        case 1 :
            view.title = K.latestEventHeader
            return view

        case 2:
            view.title = K.teamHeader
            return view

        default :
            return UICollectionReusableView()
        }
    }
    
    
    

}
