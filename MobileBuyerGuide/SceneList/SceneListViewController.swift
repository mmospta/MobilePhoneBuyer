//
//  SceneListViewController.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol SceneListViewControllerInterface: class {
  func displaySomething(viewModel: SceneList.Something.ViewModel)
}

class SceneListViewController: UIViewController, SceneListViewControllerInterface {
  var interactor: SceneListInteractorInterface!
  var router: SceneListRouter!

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
  }

  // MARK: - Event handling

  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work

    let request = SceneList.Something.Request()
    interactor.doSomething(request: request)
  }

  // MARK: - Display logic

  func displaySomething(viewModel: SceneList.Something.ViewModel) {
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
