import UIKit

enum GameObject: String{
    case map = "🟩"
    case hero = "👾"
    case box = "🗽"
    case finish = "🛸"
    //case border = "▫️"
}

enum Direction: String {
    case left, right, up, down
}

class Room {
    let width: Int
    let height: Int
    var roomArray = [[GameObject]]()
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        
        for _ in 0..<height {
            var line = [GameObject]()
            for _ in 0..<width {
                line.append(.map)
            }
            self.roomArray.append(line)
        }
    }
    
    func showRoom() {
        let border: Character = "🟦"
        let topRoom = String(Array(repeatElement(border, count: roomArray.count + 2)))
        print(topRoom)
        
        for line in roomArray {
            var stringLine = String(border)
            for coordinate in line {
                stringLine += coordinate.rawValue
            }
            stringLine += String(border)
            print(stringLine)
        }
        print(topRoom)
    }
}

class Player {
    var x: Int
    var y: Int
    let room: Room
    
    init(x: Int, y: Int, room: Room){
        self.x = x
        self.y = y
        self.room = room
        
        room.roomArray[x][y] = GameObject.hero
    }
    
}

let room = Room(width: 7, height: 7)
let player = Player(x: 0, y: 0, room: room)
room.showRoom()
