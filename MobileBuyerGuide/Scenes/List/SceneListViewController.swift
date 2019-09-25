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
  func displayPhone(viewModel: SceneList.GetPhone.ViewModel)
  func displayFavouriteId(viewModel: SceneList.TapFavourite.ViewModel)
  func displayTapSelectRow(viewModel: SceneList.TapSelectRow.ViewModel)
}

class SceneListViewController: UIViewController, SceneListViewControllerInterface {
  
  var interactor: SceneListInteractorInterface!
  var router: SceneListRouter!
  var mobileListData: [PhoneElement] = []
  var favouriteId: [Int] = []
  var hiddenButton: Bool?
  
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
    getPhoneOnLoad()
    setupUISegmentControl()
  }
  
  // MARK: - Element Setup
  
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
  
  // MARK: - Event handling
  
  func getPhoneOnLoad() {
    let request = SceneList.GetPhone.Request(state: .all)
    interactor.getPhone(request: request)
  }
  
  @IBAction func segmentControlChange(_ sender: Any) {
    switch segmentControl.selectedSegmentIndex {
    case 0:
      let request = SceneList.GetPhone.Request(state: .all)
      interactor.getAllData(request: request)
      
    case 1:
      let request = SceneList.GetPhone.Request(state: .favourite)
      interactor.getFavouriteData(request: request)
      
    default:
      break;
    }
  }
  
  @IBAction func sortButton(_ sender: Any) {
    let alertController = UIAlertController(title: "Sort", message: "", preferredStyle: .alert)
    let action1 = UIAlertAction(title: "Price low to high", style: .default) { (action:UIAlertAction) in
      let request = SceneList.SortPhone.Request(sortType: .priceLowToHigh)
      self.interactor.getSortPhone(request: request)
    }
    
    let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
      print("You've pressed cancel");
    }
    
    let action3 = UIAlertAction(title: "Price high to low", style: .default) { (action:UIAlertAction) in
      let request = SceneList.SortPhone.Request(sortType: .priceHighToLow)
      self.interactor.getSortPhone(request: request)
    }
    
    let action4 = UIAlertAction(title: "Rating", style: .default) { (action:UIAlertAction) in
      let request = SceneList.SortPhone.Request(sortType: .ratingHighToLow)
      self.interactor.getSortPhone(request: request)
    }
    
    alertController.addAction(action1)
    alertController.addAction(action2)
    alertController.addAction(action3)
    alertController.addAction(action4)
    self.present(alertController, animated: true, completion: nil)
  }
  
  
  // MARK: - Display logic
  
  func displayPhone(viewModel: SceneList.GetPhone.ViewModel) {
    mobileListData = viewModel.passData
    tableView.reloadData()
  }
  
  func displayFavouriteId(viewModel: SceneList.TapFavourite.ViewModel) {
    favouriteId = viewModel.favouriteId
    tableView.reloadData()
  }
  
  func displayTapSelectRow(viewModel: SceneList.TapSelectRow.ViewModel) {
    //    print("Tap Select Row ID = \(viewModel.mobileId)")
    router.navigateToSomewhere()
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


// MARK: Extension

extension SceneListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mobileListData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "phoneListViewCell", for: indexPath) as! ListViewCell
    let cellData = mobileListData[indexPath.row]
    cell.configCell(phone: cellData, favouriteId: favouriteId)
    cell.hiddenFavouriteButton(bool: hiddenButton ?? false)
    cell.favouriteButtonAction = {
      let favouriteId: Int = cellData.id
      self.interactor.setFavouritePhone(request: SceneList.TapFavourite.Request(favouriteId: favouriteId))
      // delegate cell
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let mobileDataAtRow: PhoneElement = mobileListData[indexPath.row]
    let request = SceneList.TapSelectRow.Request(responseData: mobileDataAtRow)
    interactor.tapSelectRow(request: request)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      print("delete")
      let favouriteId: Int = mobileListData[indexPath.row].id
      print(favouriteId)
      interactor.setFavouritePhone(request: SceneList.TapFavourite.Request(favouriteId: favouriteId))
      self.mobileListData.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return hiddenButton ?? false
  }
}
