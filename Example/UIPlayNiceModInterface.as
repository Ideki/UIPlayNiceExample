package
{
	import flash.display.MovieClip;
	import Shared.Components.ButtonControls.ButtonBar.ButtonBar;
	
	public interface UIPlayNiceModInterface {
		// Prepare your buttons for the menu button bar
		function PrepareButtons():Array;
		
		// Process user events (ex: button press)
		// param1: Name of the event
		// param2: True = button is being pressed, False = button is released (it is always better to process the events when the button is released, not pressed)
		// Return: true if you handled the event, false otherwise
		function ProcessUserEvent(param1:String, param2:Boolean) : Boolean;
		
		// Process events from the game here
		function ProcessDataEvent(eventData:UIPlayNiceEventData): void;
		
		// Handle Left stick updates
		// param1: horizontal delta between previous input and this one
		// param2: vertical delta between previous input and this one
		// Return: true if you handled the input, false otherwise
		function OnLeftStickInput(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Boolean) : Boolean;
		
		// Handle Right stick updates
		// param1: horizontal delta between previous input and this one
		// param2: vertical delta between previous input and this one
		// Return: true if you handled the input, false otherwise
		// NOTE: Not all menu receive the Right Stick input
		function OnRightStickInput(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Boolean) : Boolean;
		
		// Provides access to the menu
		// NOTE: be careful/mindful about what you are doing with the menu because other mods might modify it too.
		// If you replace some UI elements, make sure to not change the names they might define internaly
		function SetMenu(menu:MovieClip): void;
   }
}
