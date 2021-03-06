//
//  ProduceVC.swift
//  Seasonality
//
//  Created by Alex 6.1 on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProduceVC: UIViewController {
    
    //MARK: PROPERTIES
    var produce = [Produce]() { didSet { tableview.reloadData() } }
    
    //MARK: VIEWS
    lazy var tableview: UITableView = {
        var tv = UITableView()
        tv.register(ProduceCell.self, forCellReuseIdentifier: "ProduceCell")
        return tv
    }()
    
    //MARK: LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        constrainTableView()
        tableview.delegate = self
        tableview.dataSource = self
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadProduce()
        tableview.reloadData()
    }
    
    //MARK: PRIVATE FUNCTIONS
    
    private func loadProduce() {

        FirestoreService.manager.getAllProduce { (result) in
            switch result {
            case .failure(let error):
                print("error getting produce" )
            case .success(let data):
                self.produce = data
            }
        }
    }
    

    
    //MARK: CONSTRAINTS
    private func constrainTableView() {
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: HANDLER FUNCTIONS
    private func handlePostResponse(withResult result: Result<Void, Error>) {
        switch result {
        case .success:
            let alertVC = UIAlertController(title: "Success", message: "Event has been added to favorites.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] (action)  in
                DispatchQueue.main.async {
                    self!.tableview.reloadData()
                }
            }))
            present(alertVC, animated: true, completion: nil)
        case let .failure(error):
            print("Error occurred adding the favorite: \(error)")
        }
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
}


extension ProduceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produce.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let produceType = produce[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProduceCell") as? ProduceCell else {
            return UITableViewCell()}
        
        cell.produceName.text = produceType.name
        
        ImageHelper.shared.getImage(urlStr: produceType.image) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    cell.produceImage.image = UIImage(named: "defaultimage")
                case .success(let produceImage):
                    cell.produceImage.image = produceImage
                }
            }
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let food = produce[indexPath.row]
        print(food)
//        let dvc = TMDetailVC()
//        dvc.modalPresentationStyle = .currentContext
//        let eventDetails = events[indexPath.row]
//        dvc.event = eventDetails
//        self.present(dvc, animated: true, completion: nil)
    }
    
}

//extension ProduceVC: FavoriteCellDelegate {
//    func favorite(tag: Int) {
//        let event = events[tag]
//        var favoriteID = ""
//
//        switch favorites.contains(where: { $0.eventID == events[tag].id }) {
//
//        case false:
//            guard let user = FirebaseAuthService.manager.currentUser else { return }
//            guard let image = event.images?[1].url,
//                let name = event.name,
//                let date = event.dates?.start?.localDate,
//                let id = event.id else { return }
//
//            let newFavorite = Favorite(from: user, eventImage: image, eventName: name, eventDate: date, eventID: id)
//            favorites.append(newFavorite)
//            FirestoreService.manager.createFavorite(favorite: newFavorite) { (result) in
//                self.handlePostResponse(withResult: result)
//            }
//        case true:
//            for (index,value) in favorites.enumerated() {
//                if value.eventID == event.id {
//                    favorites.remove(at: index)
//                    favoriteID = value.favoriteID!
//                }
//            }
//            FirestoreService.manager.deleteFavorite(favoriteID: favoriteID) { (result) in
//                self.handlePostResponse(withResult: result)
//            }
//            tableview.reloadData()
//            self.showAlert(with: "Removed", and: "Event has been unfavorited!")
//        }
//    }
//
//}
