//
//  ResponseModel.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 26.06.2024.
//

import Foundation

protocol Responsable {
    associatedtype Model
    
    var models: [Model] { get }
}

struct InstrumentsResponseModel: Decodable, Responsable {
    typealias Model = InstrumentModel
    
    private let instruments: [InstrumentModel]
    
    // MARK: - Responsable
    
    var models: [InstrumentModel] {
        return instruments
    }
}

let responseModel = """
    {
        apiTradeAvailableFlag = 1;
        blockedTcaFlag = 0;
        classCode = TQBR;
        figi = BBG004730N88;
        first1dayCandleDate = "2000-01-04T07:00:00Z";
        first1minCandleDate = "2018-03-07T18:33:00Z";
        forIisFlag = 1;
        forQualInvestorFlag = 0;
        instrumentKind = "INSTRUMENT_TYPE_SHARE";
        instrumentType = share;
        isin = RU0009029540;
        name = "Сбербанк";
        positionUid = "41eb2102-5333-4713-bf15-72b204c4bf7b";
        ticker = SBER;
        uid = "e6123145-9665-43e0-8413-cd61b8aa9b13";
        weekendFlag = 1;
    }
"""
