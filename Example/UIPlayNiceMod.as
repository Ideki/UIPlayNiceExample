package {
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import flash.events.Event;

	import com.adobe.serialization.json.JSONDecoder;

	import Shared.AS3.Data.BSUIDataManager;
	import Shared.AS3.Events.CustomEvent;
	import Shared.Components.ButtonControls.ButtonBar.ButtonBar;
	import Shared.GlobalFunc;

	import UIPlayNiceJsonEncoder;

	public class UIPlayNiceMod extends MovieClip {
		public var errorHolder_mc: MovieClip;

		private var _displayName: String = "";

		protected var _playerData: Object;

		private var _allSettings: Dictionary = new Dictionary();
		
		private var _linkedSystems:Array = [];

		public function UIPlayNiceMod() {
			super();

			addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			
			LoadLinkedSystems();
		}

		public function set DisplayName(value: String): void {
			_displayName = value;
		}

		public function get DisplayName(): String {
			return _displayName;
		}

		public function SetPlayerData(playerData: Object): void {
			_playerData = playerData;
		}

		protected function onAddedToStage(param1: Event): * {
			if (_errorText) {
				AppendError("");
			}
			else {
				errorHolder_mc.visible = false;
				GlobalFunc.SetText(this.errorHolder_mc.text_tf,"");
			}
		}
	
		private function LoadLinkedSystems():void {
			_linkedSystems = [];
			
			_linkedSystems.push([386524]); // Al-Battani
			_linkedSystems.push([386585]); // Alchiba
			_linkedSystems.push([386500]); // Algorab
			_linkedSystems.push([386575, 386574]); // Alpha Andraste, Beta Andraste
			_linkedSystems.push([386570, 386610]); // Alpha Centauri, Toliman
			_linkedSystems.push([386542, 386541]); // Alpha Marae, Beta Marae
			_linkedSystems.push([386510, 386512, 386511]); // Alpha Ternion, Beta Ternion, Proxima Ternion
			_linkedSystems.push([386591, 386590]); // Alpha Tirna, Beta Tirna
			_linkedSystems.push([386530]); // Altair
			_linkedSystems.push([386538]); // Andromas
			_linkedSystems.push([386499]); // Archimedes
			_linkedSystems.push([386573]); // Arcturus
			_linkedSystems.push([386572, 386528]); // Bannoc Secondus, Bannoc
			_linkedSystems.push([386579]); // Bara
			_linkedSystems.push([386604]); // Bardeen
			_linkedSystems.push([386537]); // Barnard's Star
			_linkedSystems.push([386521]); // Bel
			_linkedSystems.push([386526, 386527]); // Bessel, Piazzi
			_linkedSystems.push([386495]); // Bohr
			_linkedSystems.push([386606, 386605]); // Bolivar, Rivera
			_linkedSystems.push([386555, 386554]); // Bradbury, McClure
			_linkedSystems.push([386597, 386598]); // Carinae, Eta Cassiopeia
			_linkedSystems.push([386503]); // Celebrai
			_linkedSystems.push([386525]); // Charybdis
			_linkedSystems.push([386567, 386566]); // Cheyenne, Maheo
			_linkedSystems.push([386561, 386560]); // Copernicus, Copernicus Minor
			_linkedSystems.push([386518]); // Decaran
			_linkedSystems.push([386529]); // Delta Pavonis
			_linkedSystems.push([386562, 386563]); // Delta Vulpes, Gamma Vulpes
			_linkedSystems.push([386589]); // Denebola
			_linkedSystems.push([386509]); // Enlil
			_linkedSystems.push([386603]); // Eridani
			_linkedSystems.push([386498]); // Fermi
			_linkedSystems.push([386539]); // Feynman
			_linkedSystems.push([386569]); // Foucault
			_linkedSystems.push([386568]); // Freya
			_linkedSystems.push([386587]); // Groombridge
			_linkedSystems.push([386550, 386549]); // Guniibuu, Indum
			_linkedSystems.push([386497]); // Hawking
			_linkedSystems.push([386513]); // Heinlein
			_linkedSystems.push([386551]); // Heisenberg
			_linkedSystems.push([386496]); // Huygens
			_linkedSystems.push([386571]); // Hyla
			_linkedSystems.push([386582]); // Ixyll
			_linkedSystems.push([386556]); // Jaffa
			_linkedSystems.push([386504]); // Kang
			_linkedSystems.push([386602]); // Kapteyn's Star
			_linkedSystems.push([386502]); // Katydid
			_linkedSystems.push([386523]); // Khayyam
			_linkedSystems.push([386558]); // Kryx
			_linkedSystems.push([386592]); // Kumasi
			_linkedSystems.push([386588]); // Lantana
			_linkedSystems.push([386506]); // Leonis
			_linkedSystems.push([386534]); // Leviathan
			_linkedSystems.push([386532]); // Linnaeus
			_linkedSystems.push([386609]); // Lunara
			_linkedSystems.push([386601]); // Luyten's Star
			_linkedSystems.push([386501]); // Maal
			_linkedSystems.push([386584]); // Marduk
			_linkedSystems.push([386552]); // Masada
			_linkedSystems.push([386576]); // Moloch
			_linkedSystems.push([386577]); // Muphrid
			_linkedSystems.push([386608, 386607]); // Narion, Valo
			_linkedSystems.push([386544]); // Nemeria
			_linkedSystems.push([386531]); // Newton
			_linkedSystems.push([386517]); // Nikola
			_linkedSystems.push([386614]); // Nirah
			_linkedSystems.push([386586]); // Nirvana
			_linkedSystems.push([386548, 386547]); // Oborum Prime, Oborum Proxima
			_linkedSystems.push([386565, 386564]); // Olympus, Aranae
			_linkedSystems.push([386615]); // Ophion
			_linkedSystems.push([386583]); // Porrima
			_linkedSystems.push([386600, 386599]); // Procyon A, Procyon B
			_linkedSystems.push([386522]); // Pyraas
			_linkedSystems.push([386520]); // Rana
			_linkedSystems.push([386540]); // Rasalhague
			_linkedSystems.push([386581]); // Rutherford
			_linkedSystems.push([386508]); // Sagan
			_linkedSystems.push([386543]); // Sakharov
			_linkedSystems.push([386536]); // Schrodinger
			_linkedSystems.push([386559]); // Serpentis
			_linkedSystems.push([386578]); // Shoza
			_linkedSystems.push([386613, 405964]); // Sirius, The Pup
			_linkedSystems.push([386507]); // Sol
			_linkedSystems.push([386557]); // Sparta
			_linkedSystems.push([386519]); // Strix
			_linkedSystems.push([386514]); // Syrma
			_linkedSystems.push([386535]); // Tau Ceti
			_linkedSystems.push([386553]); // Tidacha
			_linkedSystems.push([386594, 386593]); // Ursae Majoris, Ursae Minoris
			_linkedSystems.push([386596]); // Van Maanen's Star
			_linkedSystems.push([386533]); // Vega
			_linkedSystems.push([386515]); // Verne
			_linkedSystems.push([386580]); // Volii
			_linkedSystems.push([386611]); // Wolf
			_linkedSystems.push([386546, 386545]); // Xi Ophiuchi, Zeta Ophiuchi
			_linkedSystems.push([386516]); // Zelazny
			_linkedSystems.push([386595]); // Zosma
		}
	
		protected function GetSystemIDForIcon(systemId:int):int {
			var mainSystem:int = systemId;
			
			for (var i:int = 0; i < _linkedSystems.length; i ++) {
				if (_linkedSystems[i].indexOf(systemId) >= 0) {
					mainSystem = _linkedSystems[i][0];
					break;
				}
			}
			
			return mainSystem
		}

		//---------------------

		private var _errorText: String = "";
		protected function OnError(param1: CustomEvent) {
			var text: String = "";
			if (param1.params is Error) {
				text = param1.params.message;
			} else if (param1.params is String ||
				param1.params is Number ||
				param1.params is int) {
				text = param1.params.toString();
			} else {
				text = "Error";
			}
			AppendError(text);
		}

		public function AppendError(text: String, maxLines: int = 0): void {
			if (!text) {
				return;
			}
		
			var d:Date = new Date();
			var timeString:String = doubleDigitFormat(d.hours) + ":" + doubleDigitFormat(d.minutes) + ":" + doubleDigitFormat(d.seconds);
			_errorText += timeString + " " + text + "\n";

			if (maxLines > 0) {
				var split = _errorText.split("\n");
				var count: int = split.length - 1;
				if (count >= maxLines) {
					_errorText = "";
					for (var i: int = count - maxLines; i < count; i++) {
						_errorText += split[i] + "\n";
					}
				}
			}

			if (errorHolder_mc != null) {
				errorHolder_mc.visible = true;
				GlobalFunc.SetText(this.errorHolder_mc.text_tf, _errorText);
			}
		}

		public static function getProperties(obj: * , depth: int = 0): String {
			var p: * ;
			var res: String = '{';
			var val: String;
			var prop: String;
			for (p in obj) {
				prop = String(p);
				if (prop && prop !== '' && prop !== ' ') {
					if (obj[p] is String) {
						val = String(obj[p]);
						res += SpacePadding(depth) + '"' + prop + '"' + ': "' + val + '",\n';
					} else if (obj[p] is Number) {
						val = obj[p].toString();
						res += SpacePadding(depth) + '"' + prop + '"' + ': ' + val + ',\n';
					} else if (obj[p] is Boolean) {
						val = obj[p].toString();
						res += SpacePadding(depth) + '"' + prop + '"' + ': ' + val + ',\n';
					} else if (obj[p] is Array) {
						val = getProperties(obj[p], depth + 1);
						res += SpacePadding(depth) + '"' + prop + '"' + ': [' + val + '],\n';
					} else {
						val = getProperties(obj[p], depth + 1);
						res += SpacePadding(depth) + '"' + prop + '"' + ': ' + val + ',\n';
					}
				}
			}
			res += "},"
			return res;
		}

		private static function SpacePadding(depth: int): String {
			var spaces: String = "";
			for (var i: int = 0; i < depth; i++) {
				spaces += "  ";
			}
			return spaces;
		}
		
		function doubleDigitFormat($num:uint):String {
			if ($num < 10) {
				return ("0" + $num);
			}
			return String($num);
		}
	}
}