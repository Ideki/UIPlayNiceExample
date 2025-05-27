package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import Shared.AS3.Events.CustomEvent;
	import Shared.AS3.Data.BSUIDataManager;
	import Shared.Components.ButtonControls.ButtonData.ButtonBaseData;
	import Shared.Components.ButtonControls.ButtonData.UserEventData;
	import Shared.GlobalFunc;
	
	import UIPlayNiceEventData;
	import UIPlayNiceModButton;
	import UIPlayNiceModInterface;
	
	public class UIPlayNiceExample extends UIPlayNiceMod implements UIPlayNiceModInterface {
		// Remove this if you do no need your own cursor
		public var Cursor_mc:MovieClip;
		
		// The list of UIPlayNiceModButton that holds your buttons data and the instance of your buttons
		private var buttons:Array = new Array();
		
		public function UIPlayNiceExample() {
			DisplayName = "UIPlayNiceExample";
			
			super();
			
			// Remove this if you do no need your own cursor
			Cursor_mc.visible = false;
			addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
		}
	
//----------------------------
// Interface mandatory functions
   
		// Add buttons to the menu button bar
		public function PrepareButtons():Array {
			// Sample button
			var buttonData:ButtonBaseData = new ButtonBaseData("Dummy button",[new UserEventData("Select", this.OnDummyButton)]);
			var button:UIPlayNiceModButton = new UIPlayNiceModButton("BasicButton", buttonData, true);
			buttons.push(button);
			
			return buttons;
		}
		
		// Process user events (ex: button press)
		// param1: Name of the event
		// param2: True = button is being pressed, False = button is released (it is always better to process the events when the button is released, not pressed)
		// Return:	1	if you handled the event,
		// 			-1	if you do NOT handle the event AND the menu should NOT handle the event
		// 			0	if you do NOT handle the event AND the menu SHOULD handle the event
		public function ProcessUserEvent(param1:String, param2:Boolean) : int {
			//AppendError("ProcessUserEvent " + param1);
			
			var _loc3_:int = 0;
			try {
				// Process the sample button event
				if (param1 == "Select" && param2 == false) {
					OnDummyButton();
					return 1;
				}
			}
			catch(error:Error)
			{
				AppendError(error.message);
			}
			
			return _loc3_;
		}
	
		// Process events from the game here
		public function ProcessDataEvent(eventData:UIPlayNiceEventData): void {
			// Uncomment the following 2 lines to see events you receive from the game for the menu
			// AppendError(eventData.EventName);
			// AppendError(getProperties(eventData.EventData, 0));
			
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
	
		// Receive data from Papyrus
		public function ForwardedDataFromPapyrus(commandAndData:String): void {
			try {
				var splitted:Array = commandAndData.split("|");
				var command:String = splitted[0];
				// Uncomment the following 2 lines to see events you receive from papyrus for the menu
				// AppendError(command);
				// AppendError(splitted[1]);
			
				switch(command) {
					case "SomeCommandFromPapyrus":
					break;
				}
			}
			catch(error:Error) {
				AppendError("ForwardedDataFromPapyrus error: " + error.message);
			}
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
	}
}
