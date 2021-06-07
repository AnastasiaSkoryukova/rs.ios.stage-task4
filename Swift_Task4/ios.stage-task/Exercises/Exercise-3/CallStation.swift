import Foundation

final class CallStation {
    var allUsersArray = [User]()
    var callsArray = [Call]()
    var currentCall: Call?
}



extension CallStation: Station {
    func users() -> [User] {
        
        
        
        
       return allUsersArray
    }
    
    func add(user: User) {
        if !allUsersArray.contains(user) {
        allUsersArray.append(user)
        }
    }
    
    func remove(user: User) {

    }
    
    func execute(action: CallAction) -> CallID? {
        
        
        switch action {
        case .start(from: let from, to: let to):

            let newCall = Call(id: CallID(uuid: UUID().uuid), incomingUser: from, outgoingUser: to, status: .calling)
                self.currentCall = newCall
                self.callsArray.append(newCall)
                return newCall.id
            
        
           
                
           
        case .answer(from: let from):
            
            var call: Call
            
            
            for element in callsArray {
                if element.incomingUser.id == from.id || element.outgoingUser.id == from.id {
                    if element.status == .calling {
                    call = Call(id: element.id, incomingUser: element.incomingUser, outgoingUser: element.outgoingUser, status: .talk)
                    self.currentCall = call
                        if let i = callsArray.firstIndex(where: {$0.id == self.currentCall?.id}) {
                        callsArray.remove(at: i)
                        callsArray.insert(call, at: i)
                        return call.id
                    } else if element.status == .talk {
                        call = Call(id: element.id, incomingUser: element.incomingUser, outgoingUser: element.outgoingUser, status: .ended(reason: .userBusy))
                        self.currentCall = call
                        
                    }
                    
                    }
                    
                }
                
                
            
            }
            
            
            
        case .end(from: let from):
            
            
            
            var call: Call
            
            for element in callsArray {
                if element.incomingUser.id == from.id || element.outgoingUser.id == from.id {
                    
                    if element.status == .talk {
                    call = Call(id: element.id, incomingUser: element.incomingUser, outgoingUser: element.outgoingUser, status: .ended(reason: .end))
                        self.currentCall = call
                        if let i = callsArray.firstIndex(where: {$0.id == element.id}) {
                        callsArray.remove(at: i)
                        callsArray.insert(call, at: i)
                        }
                        return call.id
                    } else if element.status == .calling {
                        call = Call(id: element.id, incomingUser: element.incomingUser, outgoingUser: element.outgoingUser, status: .ended(reason: .cancel))
                        self.currentCall = call
                        if let i = callsArray.firstIndex(where: {$0.id == element.id}) {
                        callsArray.remove(at: i)
                        callsArray.insert(call, at: i)
                        }
                        return call.id
                    }
                    
                    
                    
                } 
                
            }
        }
        
        
       return nil
    }
    
    func calls() -> [Call] {
        
        
        
        return callsArray
    }
    
    func calls(user: User) -> [Call] {
        var callsOfTheUserArray = [Call]()
        for call in callsArray {
            
            
            if call.incomingUser.id == user.id || call.outgoingUser.id == user.id {
                callsOfTheUserArray.append(call)
            }
        }
        
        return callsOfTheUserArray
    }
    
    func call(id: CallID) -> Call? {
        nil
    }
    
    func currentCall(user: User) -> Call? {
        if self.currentCall?.incomingUser.id == user.id || self.currentCall?.outgoingUser.id == user.id {
            if self.currentCall?.status == .ended(reason: .end) {
                return nil
            } else if self.currentCall?.status == .ended(reason: .cancel) {
                return nil
            } else {
                return self.currentCall
            }
            
        }
        
        
        return nil
    }
}
