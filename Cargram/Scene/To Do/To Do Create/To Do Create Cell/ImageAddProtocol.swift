//
//  ImageAddProtocol.swift
//  Cargram
//
//  Created by Ferhan Akkan on 16.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

protocol ImageAddProtocol {
    func imageProtocolAdd()
}

protocol ImageRemoveProtocol {
    func imageProtocolRemove(selectedCell: Int)
}

protocol ImageDetailShow {
    func imageProtocolShow(selectedCell: Int)
}
