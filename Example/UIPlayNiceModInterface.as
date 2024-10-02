package
{
	import flash.display.MovieClip;
	import Shared.Components.ButtonControls.ButtonBar.ButtonBar;
	
	public interface UIPlayNiceModInterface {
		function PrepareButtons(buttonBar_mc:ButtonBar):void;
		
		function ProcessUserEvent(param1:String, param2:Boolean) : Boolean;
		
		function ProcessDataEvent(eventData:UIPlayNiceEventData): void;
		
		function OnLeftStickInput(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Boolean) : Boolean;
		
		function OnRightStickInput(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Boolean) : Boolean;
		
		function SetMenu(menu:MovieClip): void;
   }
}
