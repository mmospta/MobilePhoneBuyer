//
//  SceneListStore.swift
//  MobileBuyerGuide
//
//  Created by Phonthep Aungkanukulwit on 16/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation

/*
 
 The SceneListStore class implements the SceneListStoreProtocol.
 
 The source for the data could be a database, cache, or a web service.
 
 You may remove these comments from the file.
 
 */

class SceneListStore: SceneListStoreProtocol {
    let apiManager = APIManager()
    func getData(_ completion: @escaping (Result<Phone>) -> Void) {
        self.apiManager.getPhones(completion: { (response) in
            completion(response)
    })
    }
}

