package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import Shared.AS3.Events.CustomEvent;
	import Shared.Components.ButtonControls.ButtonBar.ButtonBar;
	import Shared.Components.ButtonControls.Buttons.ButtonBase;
	import Shared.Components.ButtonControls.ButtonData.ButtonBaseData;
	import Shared.Components.ButtonControls.ButtonData.UserEventData;
	import Shared.Components.ButtonControls.ButtonFactory.ButtonFactory;
	import Shared.Components.ButtonControls.Buttons.IButton;
	import Shared.GlobalFunc;
	
	import UIPlayNiceEventData;
	import UIPlayNiceModInterface;
	
	public class UIPlayNiceExample extends MovieClip implements UIPlayNiceModInterface {
		// A MovieClip containing a TextField to display message
		// Used mostly to debug error messages or display events data
		public var errorHolder_mc:MovieClip;
		
		// Remove this if you do no need your own cursor
		public var Cursor_mc:MovieClip;
		
		private var dummyButton:ButtonBase = null;
		
		public function UIPlayNiceExample() {
			super();
			
			errorHolder_mc.visible = false;
			
			// Remove this if you do no need your own cursor
			Cursor_mc.visible = false;
			addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
		}
	
//----------------------------
// Interface mandatory functions
   
		// Add buttons to the menu button bar
		public function PrepareButtons(buttonBar_mc:ButtonBar):void {
			// Sample button
			var buttonData:ButtonBaseData = new ButtonBaseData("Dummy button",[new UserEventData("Select", this.OnDummyButton)]);
			// Flip the next 2 lines if you want your buttons to be on the left or the right side or the menu normal buttons
			dummyButton = ButtonFactory.AddToButtonBarLeft("BasicButton",buttonData, buttonBar_mc) as ButtonBase;
			//dummyButton = ButtonFactory.AddToButtonBar("BasicButton",buttonData, buttonBar_mc) as ButtonBase;
		}
		
		// Process user events (ex: button press)
		// param1: Name of the event
		// param2: True = button is being pressed, False = button is released (it is always better to process the events when the button is released, not pressed)
		// Return: true if you handled the event, false otherwise
		public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean {
			// Remove the following line if you plan to handle user events on your own
			return false;
			
			//AppendError("ProcessUserEvent " + param1);
			
			var _loc3_:Boolean = false;
			try {
				// Process the sample button event
				if (param1 == "Select" && param2) {
					OnDummyButton();
					return true;
				}
			}
			catch(error:Error)
			{
				AppendError(error.message);
			}
			
			return false;
		}
	
		// Process events from the game here
		public function ProcessDataEvent(eventData:UIPlayNiceEventData): void {
			// Uncomment the following 2 lines to see events you receive from the game for the menu
			AppendError(eventData.EventName);
			// AppendError(getProperties(eventData.EventData), 0);
			
			switch(eventData.EventName) {
				case "SomeEventFromTheGame":
				break;
			}
		}
	
		// Handle Left stick updates
		// param1: horizontal delta between previous input and this one
		// param2: vertical delta between previous input and this one
		// Return: true if you handled the input, false otherwise
		public function OnLeftStickInput(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Boolean) : Boolean {
			// Remove the following line if you plan to handle the LeftStick on your own
			return false;

			// Use this when you have a custom cursor to display for controllers since some menu
			// use the left stick to highlight things (ex: radial menu with our character in the middle)
			
			//AppendError(param1.toString() + " " + param2.toString());

			// Change the value of speedIncrease to increase the speed of your cursor
			const speedIncrease:Number = 10;
			Cursor_mc.visible = true;
			var changed:Boolean = false;
			var newX:Number = Cursor_mc.x + (param1 * speedIncrease);			
			if (newX >= 0 && newX < stage.stageWidth) {
				Cursor_mc.x = newX;
				changed = true;
			}
			var newY:Number = Cursor_mc.y + (param2 * speedIncrease);
			if (newY >= 0 && newY < stage.stageHeight) {
				Cursor_mc.y = newY;
				changed = true;
			}
		
			if (changed) {
				// The cursor moved, you should check if it over any of your interactive controls
				CheckAfterMove();
			}
			return true;
		}
	
		// Handle Right stick updates
		// param1: horizontal delta between previous input and this one
		// param2: vertical delta between previous input and this one
		// Return: true if you handled the input, false otherwise
		public function OnRightStickInput(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Boolean) : Boolean  {
			// NOTE: Not all menu receive the Right Stick input
			return false;
		}
	
		// Provides access to the menu
		public function SetMenu(menu:MovieClip): void {
			// NOTE: be careful/mindful about what you are doing with the menu because other mods might modify it too.
			// If you replace some UI elements, make sure to not change the names they might define internaly
		}
	
//----------------------------
// Your own code
	
		public function onMouseMove(param1:MouseEvent) : void {
			Cursor_mc.visible = false;
			Cursor_mc.x = stage.mouseX;
			Cursor_mc.y = stage.mouseY;
			CheckAfterMove();
		}
	
		private function CheckAfterMove() {
			// Got to find any collision
		}
	
		private function OnDummyButton():void {
			AppendError("Dummy button pressed");
		}
	
//----------------------------
// Helper functions
	
		private var _errorText:String = "";
		private function OnError(param1:CustomEvent) {
			var text:String = "";
			if (param1.params is Error){
				text = param1.params.message;
			}
			else if (param1.params is String ||
				param1.params is Number ||
				param1.params is int) {
				text = param1.params.toString();
			}
			else {
				text = "Error";
			}
			AppendError(text);
		}
		
		private function AppendError(text:String):void {
			_errorText += text + "\n";
			errorHolder_mc.visible = true;
			GlobalFunc.SetText(this.errorHolder_mc.text_tf, _errorText);
		}
	
		public static function getProperties(obj:*, depth:int):String  {
            var p:*;
            var res:String = '{';
            var val:String;
            var prop:String;
            for (p in obj) {
                prop = String(p);
                if (prop && prop!=='' && prop!==' ') {
					if (obj[p] is String) {
						val = String(obj[p]);
						res += SpacePadding(depth) + '"'+prop+'"'+': "'+val+'",\n';
					}
					else if(obj[p] is Number) {
						val = obj[p].toString();
						res += SpacePadding(depth) + '"'+prop+'"'+': '+val+',\n';
					}
					else if(obj[p] is Boolean) {
						val = obj[p].toString();
						res += SpacePadding(depth) + '"'+prop+'"'+': '+val+',\n';
					}
					else if(obj[p] is Array) {
						val = getProperties(obj[p], depth + 1);
						res += SpacePadding(depth) + '"'+prop+'"'+': ['+val+'],\n';
					}
					else{
						val = getProperties(obj[p], depth + 1);
						res += SpacePadding(depth) + '"'+prop+'"'+': '+val+',\n';
					}
                }
            }
			res += "},"
            return res;
        }
	
	    private static function SpacePadding(depth:int):String {
			var spaces:String = "";
			for (var i:int = 0; i < depth; i ++) {
				spaces += "  ";
			}
			return spaces;
		}
	}
}
