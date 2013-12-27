package com.netease.pomelo
{
  public class Protocol {

    private static var HEADER:int = 5;

    public static function encode(id:int, route:String, msg:Object):String {
      var msgStr = JSON.stringify(msg);

      if(route.length > 255) { 
        throw new Error('route maxlength is overflow');
      }

      var byteArray:Array = new Array();
      var index:int = 0;

      byteArray[index++] = (id >> 24) & 0xFF;
      byteArray[index++] = (id >> 16) & 0xFF;
      byteArray[index++] = (id >> 8) & 0xFF;
      byteArray[index++] = id & 0xFF;
      byteArray[index++] = route.length & 0xFF;

      var i:int = 0;
      
      for (i = 0; i < route.length; i++) {
        byteArray[index++] = route.charCodeAt(i);
      }

      for (i = 0; i < msgStr.length; i++) {
        byteArray[index++] = msgStr.charCodeAt(i);
      }

      return bt2Str(byteArray, 0, byteArray.length);
    }

    public static function decode(msg:Object):Message {
      var len:int = msg.length;
      var arr:Array = new Array(len);

      for(var idx:int = 0; idx < len; ++idx) {
        arr[idx] = msg.charCodeAt(idx);
      }

      var index = 0;
      var buf = new Array(arr);
      var id = ((buf[index++] << 24) | (buf[index++]) << 16 | (buf[index++]) << 8 | buf[index++]) >>> 0; 
      var routeLen = buf[HEADER-1];
      var route = bt2Str(buf, HEADER, routeLen + HEADER);
      var body = bt2Str(buf, routeLen + HEADER, buf.length);

      return new Message(id, route, body);
    }

    private static function bt2Str(byteArray:Array, start:int, end:int):String {
      var result = "";

      for(var i:int = start; i < byteArray.length && i < end; i++) {
        result = result + String.fromCharCode(byteArray[i]);
      }

      return result;
    }
  }
}