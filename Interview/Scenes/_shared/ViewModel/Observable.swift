//
//  Observable.swift
//  Interview
//
//  Created by Wagner Coleta on 23/04/22.
//  Copyright © 2022 PicPay. All rights reserved.
//

import Foundation

final class Observable<T> {
    
    private var listeners: [((T?) -> Void)] = []
    
    var value: T? {
        didSet {
            listeners.forEach { listener in
                listener(value)
            }
        }
    }
    
    init(_ value: T?){
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listeners.append(listener)
    }
}
