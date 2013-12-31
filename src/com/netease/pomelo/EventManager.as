package com.netease.pomelo 
{
  public class EventManager
  {
    protected var callbacks:Object;

    public function EventManager():void {
      this.callbacks = {
        requests: [],
        events: {}
      };
    }

	public function removeEventListen(eventName:String, fn:Function):void{
		if (this.callbacks.events[eventName] == null || fn==null) {
			return;
		}
		
		for(var i:int = 0; i < this.callbacks.events[eventName].length; ++i) {
			if(this.callbacks.events[eventName][i] == fn){
				delete this.callbacks.events[eventName][i];return;
			}
		}
	}
	
    public function addCallback(requestId:int, action:Function):void {
      this.callbacks.requests[requestId] = action;
    }

    public function invokeCallBack(message:Object):void {
      this.callbacks.requests[message.id](message.body);
    }

    // Call listeners to corresponding route
    public function dispatchEvent(eventName:String, message:Object):void {
      if (this.callbacks.events[eventName] == null) {
        //logger.warning("there is no listeners.");
        return;
      }

      for(var i:int = 0; i < this.callbacks.events[eventName].length; ++i) {
		  var fn:Function = this.callbacks.events[eventName][i];
		  if(fn)fn(message.body || message);
      }
    }

    public function addEventHandler(eventName:String, action:Function):void {
      if(!this.callbacks.events[eventName])
        this.callbacks.events[eventName] = [];

      this.callbacks.events[eventName].push(action);
    }
  }
}