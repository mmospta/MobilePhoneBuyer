//
//  SceneListViewController.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit
import Kingfisher

protocol SceneListViewControllerInterface: class {
  func displaySomething(viewModel: SceneList.GetPhone.ViewModel)
}

class SceneListViewController: UIViewController, SceneListViewControllerInterface {
  
  var interactor: SceneListInteractorInterface!
  var router: SceneListRouter!
  var mobileListData: Phone = []
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: SceneListViewController) {
    let router = SceneListRouter()
    router.viewController = viewController
    
    let presenter = SceneListPresenter()
    presenter.viewController = viewController
    
    let interactor = SceneListInteractor()
    interactor.presenter = presenter
    interactor.worker = SceneListWorker(store: SceneListStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    doSomethingOnLoad()
    setupUISegmentControl()
  }
  
  private func setupUISegmentControl() {
    segmentControl.backgroundColor = .clear
    segmentControl.tintColor = .clear
    
    segmentControl.setTitleTextAttributes([
      NSAttributedString.Key.font : UIFont(name: "Helvetica Neue", size: 18),
      NSAttributedString.Key.foregroundColor: UIColor.lightGray
      ], for: .normal)
    
    segmentControl.setTitleTextAttributes([
      NSAttributedString.Key.font : UIFont(name: "Helvetica Neue", size: 18),
      NSAttributedString.Key.foregroundColor: UIColor.black
      ], for: .selected)
  }
  
  func clickFavouriteButton() {
    
    
  }
  // MARK: - Event handling
  
  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work
    
    let request = SceneList.GetPhone.Request()
    interactor.doSomething(request: request)
  }
  
  // MARK: - Display logic
  
  func displaySomething(viewModel: SceneList.GetPhone.ViewModel) {
    mobileListData = viewModel.passData
    tableView.reloadData()
    
    
    
    // NOTE: Display the result from the Presenter
    
    // nameTextField.text = viewModel.name
  }
  
  // MARK: - Router
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }
  
  @IBAction func unwindToSceneListViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}

extension SceneListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mobileListData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "phoneListViewCell", for: indexPath) as! ListViewCell
    let cellData = mobileListData[indexPath.row]
    cell.configCell(phone: cellData)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}

