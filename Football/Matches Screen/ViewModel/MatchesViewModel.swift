
//
//  MatchesViewModel.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/10/22.
//
//
import SwiftUI
import Combine
import Collections

public class MatchesViewModel: ObservableObject {
    var repo: MatchesRepoProtocol
    @Published var matches : [MatchResponse]? =  []
    @Published var winnerName : String = ""
    @Published var orderedGroup: OrderedDictionary<String?, [MatchResponse]> = [:]
    @Published var showingFavs = false
    @Published var savedItems: Set<Int> = []
    @Published var id = 0
    @Published var error : ResponseError? = nil
    @Published var isDataLoaded = false
    
    init(repo: MatchesRepoProtocol){
        self.repo = repo
        
        Task(){
            let localMatches = await getMatches()
            DispatchQueue.main.async { [weak self] in
                self?.matches = localMatches
                self?.getGroupedMatches(matches: self?.matches)
                self?.savedItems = defaults.favMatches
            }
        }
    }
    
    func getMatches() async -> [MatchResponse]? {
        do {
            let footballMatches = try await repo.getMatches()
            isDataLoaded = true
            return footballMatches
        } catch (let error) {
            guard let error = error as? ResponseError  else{
                return nil
            }
            self.error = error
            isDataLoaded = false
            return []
        }
    }
    
    private func getGroupedMatches(matches: [MatchResponse]?){
        guard let matches = matches else{
            return
        }
        DispatchQueue.main.async { [weak self]  in
            self?.orderedGroup = OrderedDictionary(grouping: matches){ item in
                return item.fullDate
            }
        }
        id = getCurrentMatchID()
    }
    
    func sortFavs() {
        withAnimation() {
            filterMatches()
        }
    }
    
    func contains(_ item: MatchResponse) -> Bool {
        savedItems.contains(item.id!)
    }
    
    func toggleFav(item: MatchResponse) {
        guard let id = item.id else{return}
        if contains(item) {
            savedItems.remove(id)
            filterMatches()
            
        } else {
            savedItems.insert(id)
        }
        defaults.favMatches = savedItems
    }
    
    func getCurrentMatchID() -> Int{
        guard let matches = matches, !matches.isEmpty else{
            return 0
        }
        let upcomingMatch = matches.firstIndex { match in
            DateHelper().getMatchDate(val: match.utcDate!)! >= DateHelper().getCurrentDate()!
        }
        return matches[upcomingMatch!].id!
    }
  
    func filterMatches(){
        switch showingFavs{
        case true:
            getGroupedMatches(matches: matches?.filter { savedItems.contains($0.id!) })
            
        case false:
            getGroupedMatches(matches: matches)
        }
    }
    
}

public extension MatchesViewModel {
    static func build() -> MatchesViewModel {
        MatchesViewModel(repo: MatchesRepo.build())
    }
}
