package
{
	public class UIPlayNiceEventData {
		private var _eventName:String = "";
		
		private var _eventData:Object = null;
		
		public function UIPlayNiceEventData(eventName:String, eventData:Object) {
			_eventName = eventName;
			_eventData = eventData;
		}
		
		public function get EventName():String {
			return _eventName;
		}
		
		public function get EventData():Object {
			return _eventData;
		}
   }
}
