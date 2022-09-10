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
    let box: Box
    
    init(x: Int, y: Int, room: Room, box: Box){
        self.x = x
        self.y = y
        self.room = room
        self.box = box
        
        room.roomArray[x][y] = GameObject.hero
    }
    
    func move(direction: Direction) -> Bool {
        print("Player move: ", direction.rawValue)
        var newX = x
        var newY = y
        
        switch direction {
        case .up:
            if y <= 0 {
                return false
            }
            newY -= 1
        case .down:
            if y >= room.height - 1 {
                return false
            }
            newY += 1
            
        case .left:
            if x <= 0 {
                return false
            }
            newX -= 1
        case .right:
            if x >= room.width - 1 {
                return false
            }
            newX += 1
        }
        
        if room.roomArray[newY][newX] == GameObject.map || (room.roomArray[newY][newX] == GameObject.box && box.move(direction: direction)){
            
            room.roomArray[y][x] = GameObject.map
            room.roomArray[newY][newX] = GameObject.hero
            x = newX
            y = newY
            return true
        }
        
        if room.roomArray[newY][newX] == GameObject.finish {
            print("Congratulations. You stole The Statue of Liberty !")
        }
        return false
    }
}

class Box {
    var x: Int
    var y: Int
    let finishX: Int
    let finishY: Int
    let room: Room
    
    init(x: Int, y: Int, finishX: Int, finishY: Int, room: Room){
        self.x = x
        self.y = y
        self.finishX = finishX
        self.finishY = finishY
        self.room = room
        
        room.roomArray[y][x] = GameObject.box
        room.roomArray[finishY][finishX] = GameObject.finish
    }
    
    func isFinish() -> Bool {
        if x == finishX && y == finishY {
            room.roomArray[y][x] == .finish
            print("Finish")
            return true
        }
        return false
    }
        
    func move(direction: Direction) -> Bool {
        
        if isFinish() {
            print("Finish - over")
            return false
        }
        
        print("tSoL move: ", direction.rawValue)
        var newX = x
        var newY = y
        
        switch direction {
        case .up:
            if y <= 0 {
                return false
            }
            newY -= 1
        case .down:
            if y >= room.height - 1 {
                return false
            }
            newY += 1
            
        case .left:
            if x <= 0 {
                return false
            }
            newX -= 1
        case .right:
            if x >= room.width - 1 {
                return false
            }
            newX += 1
        }
        
        if newX != x || newY != y {
            room.roomArray[y][x] = GameObject.map
            room.roomArray[newY][newX] = GameObject.box
            x = newX
            y = newY
        }
        
        isFinish()
        return true
    }
}

let room = Room(width: 7, height: 7)
let box = Box(x: 5, y: 1, finishX: 5, finishY: 5, room: room)
let player = Player(x: 0, y: 0, room: room, box: box)

room.showRoom()

let moveArray: [Direction]
moveArray = [.down, .right, .right, .right, .right, .up, .right, .down, .down, .down, .down]

for direction in moveArray {
    player.move(direction: direction)
    room.showRoom()
}
