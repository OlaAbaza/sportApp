
import Foundation
struct Events : Codable {
	let idEvent : String?
	let strEvent : String?
	let strFilename : String?
	let strSport : String?
	let idLeague : String?
	let strLeague : String?
	let strDescriptionEN : String?
	let strHomeTeam : String?
	let strAwayTeam : String?
	let intHomeScore : String?
	let intAwayScore : String?
	let strAwayFormation : String?
	let intHomeShots : String?
	let intAwayShots : String?
	let strTimestamp : String?
	let dateEvent : String?
	let dateEventLocal : String?
	let strTime : String?
	let strTimeLocal : String?
	let idHomeTeam : String?
	let idAwayTeam : String?
	let strResult : String?
	let strVenue : String?
	let strCountry : String?
	let strCity : String?
	let strPoster : String?
	let strThumb : String?
	let strVideo : String?
	let strStatus : String?
}


struct EventsModel : Codable {
    let events : [Events]?
}

