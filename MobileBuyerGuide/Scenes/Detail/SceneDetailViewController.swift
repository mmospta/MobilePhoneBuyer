//
//  SceneDetailViewController.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneDetailViewControllerInterface: class {
  func displaySomething(viewModel: SceneDetail.GetImage.ViewModel)
  func displayCollectionView(viewModel: SceneDetail.GetDetailPhone.ViewModel)
}

class SceneDetailViewController: UIViewController, SceneDetailViewControllerInterface {
  
  var interactor: SceneDetailInteractorInterface!
  var router: SceneDetailRouter!
  var url: [String] = []
  
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var detailCollectionView: UICollectionView!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  //  override func  viewDidLayoutSubviews() {
  //    super.viewDidLayoutSubviews()
  //    .collectionViewLayout.invalidateLayout()
  //  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    detailCollectionView.collectionViewLayout.invalidateLayout()
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
    getImage()
    getDetail()
  }
  
  // MARK: - Event handling
  
  func getImage() {
    // NOTE: Ask the Interactor to do some work
    
    let request = SceneDetail.GetImage.Request()
    interactor.getImage(request: request)
  }
  
  func getDetail() {
    let request = SceneDetail.GetDetailPhone.Request()
    interactor.getDetailPhone(request: request)
  }
  
  // MARK: - Display logic
  
  func displaySomething(viewModel: SceneDetail.GetImage.ViewModel) {
    url = viewModel.url
    detailCollectionView.reloadData()
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
}

extension SceneDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = collectionView.bounds.height
    let width = collectionView.bounds.height
    //      collectionView.bounds.height
    return CGSize(width: width, height: height)
  }
}

