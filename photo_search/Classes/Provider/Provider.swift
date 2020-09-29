//
//  Provider.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/24.
//

import Foundation
import Moya

let photoProvider: MoyaProvider<PhotoService> = ProviderFactory.create()
