pomelo-flashclient
====================

修正原版本的如下问题：

Protocol.encode生成%导致的 [Error #1052: Invalid URI passed to decodeURIComponent function.]

我们使用这个库时发现服务端发过来的broadcast不能通知到回调，然后查看了com.netease.pomelo.Client的socketInputHandler方法：

protected function socketInputHandler(e:FlashSocketEvent):void {

trace("socketDataHandler: " + e.data);

  var data:Object = JSON.parse(e.data);

  if(data.id) {
    this.processMessage(data);
  } else {
    this.processMessageBatch(data);
  }
}
服务端的通知返回的格式是：{"route":"xxx","body":{}}, 在这个function的处理中会进入processMessageBatch处理，而processMessageBatch假定data是数据，导致根本就不要调用回调。

所以 socketInputHandler中的判断是否应该是 if(data.id || data.route) ...才对

增加删除注册的事件的方法