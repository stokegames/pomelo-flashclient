pomelo-flashclient
====================

����ԭ�汾���������⣺

Protocol.encode����%���µ� [Error #1052: Invalid URI passed to decodeURIComponent function.]

����ʹ�������ʱ���ַ���˷�������broadcast����֪ͨ���ص���Ȼ��鿴��com.netease.pomelo.Client��socketInputHandler������

protected function socketInputHandler(e:FlashSocketEvent):void {

trace("socketDataHandler: " + e.data);

  var data:Object = JSON.parse(e.data);

  if(data.id) {
    this.processMessage(data);
  } else {
    this.processMessageBatch(data);
  }
}
����˵�֪ͨ���صĸ�ʽ�ǣ�{"route":"xxx","body":{}}, �����function�Ĵ����л����processMessageBatch������processMessageBatch�ٶ�data�����ݣ����¸����Ͳ�Ҫ���ûص���

���� socketInputHandler�е��ж��Ƿ�Ӧ���� if(data.id || data.route) ...�Ŷ�

����ɾ��ע����¼��ķ���