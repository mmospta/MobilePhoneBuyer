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
}

class SceneDetailViewController: UIViewController, SceneDetailViewControllerInterface {
  var interactor: SceneDetailInteractorInterface!
  var router: SceneDetailRouter!

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
  }

  // MARK: - Event handling

  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work

    let request = SceneDetail.Something.Request()
    interactor.doSomething(request: request)
  }

  // MARK: - Display logic

  func displaySomething(viewModel: SceneDetail.Something.ViewModel) {
    // NOTE: Display the result from the Presenter

    // nameTextField.text = viewModel.name
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
