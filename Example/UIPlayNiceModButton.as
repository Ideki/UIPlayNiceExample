package
{
	import Shared.Components.ButtonControls.ButtonData.ButtonBaseData;
	import Shared.Components.ButtonControls.Buttons.IButton;
	
	public class UIPlayNiceModButton {
		private var _buttonType:String = "";
		
		private var _buttonData:ButtonBaseData = null;
		
		private var _leftSide:Boolean = true;
		
		private var _button:IButton = null;
		
		public function UIPlayNiceModButton(buttonType:String, buttonData:ButtonBaseData, leftSide:Boolean) {
			_buttonType = buttonType;
			_buttonData = buttonData;
			_leftSide = leftSide;
		}
		
		// The type of the button
		public function get ButtonType():String {
			return _buttonType;
		}
		
		// The data associated to the button
		public function get ButtonData():ButtonBaseData {
			return _buttonData;
		}
	
		// Should the button appear on the left or right of the game buttons ?
		public function get LeftSide():Boolean {
			return _leftSide;
		}
	
		// The instance of your button
		public function get ButtonInstance():IButton {
			return _button;
		}
		public function set ButtonInstance(value:IButton):void {
			_button = value;
		}
   }
}
