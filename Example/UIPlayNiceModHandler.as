package
{
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	
	import Shared.AS3.Data.BSUIDataManager;
	
	public class UIPlayNiceModHandler {
		private var _modName:String = "";
		
		private var _loader:Loader = null;
		private var _mod_mc:MovieClip;
		private var _loadedButtons:Boolean = false;
		
		public function UIPlayNiceModHandler(modName:String) {
			_modName = modName;
		}
		
		public function get ModName():String {
			return _modName;
		}
		
		public function get ModMovieClip():MovieClip {
			return _mod_mc;
		}
	
		public function get LoadedButtons():Boolean {
			return _loadedButtons;
			}
		public function set LoadedButtons(value:Boolean):void {
			_loadedButtons = value;
			}
	
		public function Load():void {
			_loader = new Loader();
			var loading1:URLRequest = new URLRequest(_modName + ".swf");
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onModLoaded);
			_loader.load(loading1);
		}
	
		private function onModLoaded(param1:Event) : * {
			param1.target.removeEventListener(Event.COMPLETE, this.onModLoaded);
			this._mod_mc = param1.target.content;
			BSUIDataManager.dispatchCustomEvent("UIPlayNiceModLoaded", this);
      }
   }
}
