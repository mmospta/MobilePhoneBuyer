//
//  SceneDetailViewController.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneDetailViewControllerInterface: class {
  func displaySomething(viewModel: SceneDetail.Something.ViewModel)
  func displayCollectionView(viewModel: SceneDetail.GetDetailPhone.ViewModel)
}

class SceneDetailViewController: UIViewController, SceneDetailViewControllerInterface {

  var interactor: SceneDetailInteractorInterface!
  var router: SceneDetailRouter!
  var url: [String] = []
  
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var DetailCollectionView: UICollectionView!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: SceneDetailViewController) {
    let router = SceneDetailRouter()
    router.viewController = viewController
    
    let presenter = SceneDetailPresenter()
    presenter.viewController = viewController
    
    let interactor = SceneDetailInteractor()
    interactor.presenter = presenter
    interactor.worker = SceneDetailWorker(store: SceneDetailStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    doSomethingOnLoad()
    getDetail()
  }
  
  // MARK: - Event handling
  
  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work
    
    let request = SceneDetail.Something.Request()
    interactor.getImage(request: request)
  }
  
  func getDetail() {
    let request = SceneDetail.GetDetailPhone.Request()
    interactor.getDetailPhone(request: request)
  }
  
  // MARK: - Display logic
  
  func displaySomething(viewModel: SceneDetail.Something.ViewModel) {
    url = viewModel.url
    DetailCollectionView.reloadData()
  }
  
  func displayCollectionView(viewModel: SceneDetail.GetDetailPhone.ViewModel) {
    priceLabel.text = "Price: $\(viewModel.price)"
    ratingLabel.text = "Rating: \(viewModel.rating)"
    descriptionLabel.text = viewModel.description
  }
  
  // MARK: - Router
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }
  
  @IBAction func unwindToSceneDetailViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}

extension SceneDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return url.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell
    let cellData = url[indexPath.row]
    cell.configCell(url: cellData)
    return cell
  }
  
//  let cell = tableView.dequeueReusableCell(withIdentifier: "phoneListViewCell", for: indexPath) as! ListViewCell
//  let cellData = mobileListData[indexPath.row]
//  cell.configCell(phone: cellData, favouriteId: favouriteId)
//  cell.hiddenFavouriteButton(bool: hiddenButton ?? false)
//  cell.favouriteButtonAction = {
//  let favouriteId: Int = cellData.id
//  self.interactor.favouriteButtonTapped(request: SceneList.TapFavourite.Request(favouriteId: favouriteId))
//  // delegate cell
//  }
//  return cell
//}
  
}
