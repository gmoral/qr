//
//  Mapper.swift
//  QR
//
//  Created by Guillermo Moral on 01/05/2023.
//

import Foundation

class MapperBase<E,M> {

    func mapToEntity(model: M) -> E {
        preconditionFailure("This method must be overridden")
    }

    func mapToModel(entity: E) -> M {
        preconditionFailure("This method must be overridden")
    }
}
