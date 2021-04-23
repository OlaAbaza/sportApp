import Foundation

struct Teams : Codable {
    
    let idTeam : String?
    let strTeam : String?
    let strTeamShort : String?
    let strAlternate : String?
    let intFormedYear : String?
    let strSport : String?
    let strDivision : String?
    let strManager : String?
    let strStadium : String?
    let strKeywords : String?
    let strRSS : String?
    let strWebsite : String?
    let strFacebook : String?
    let strTwitter : String?
    let strInstagram : String?
    let strDescriptionEN : String?
    let strGender : String?
    let strCountry : String?
    let strTeamBadge : String?
    let strTeamJersey : String?
    let strTeamLogo : String?
    let strTeamBanner : String?
    let strYoutube : String?
    let strLocked : String?

}
struct TeamModel : Codable {
    let teams : [Teams]?

}
