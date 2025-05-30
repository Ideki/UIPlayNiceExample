;/
UIPlayNice Registration System

- Registration should happen automatically on startup since the UI cannot currently store data

- Authors will need to register each of their swf file names sans extension (example, WatchtowerGalaxyMap.swf would be registered as WatchtowerGalaxyMap) as well as the corresponding menu each hooks into.
	- To simplify this for users, we can ENUM this information as Consts so they can't typo
	
- Author should be able to easily incorporate this (ie simple setup, well-documented tutorial)
/;

Scriptname UIPlayNice:MyUIPlayNiceManager extends Quest

; -------------------------------------
; Consts
; -------------------------------------

Bool bSendRegistrationEventsOncePerSession = false Const ; TODO - Once BGS adds the ability to persist info we can set this to true and reduce event spam

String sLogName = "MyUIPlayNiceManager" Const

String sRegistrationCommand = "UIPlayNice.RegistrationRequest" Const
String sCommandMenuDelimiter = "." Const
String sCommandStartDelimiter = ":" Const
String sRegistrationPairDelimiter = "|" Const
String sRegistrationMenusDelimiter = "," Const

String sMissionMenuOverride = "MissionMenu" Const ; Bethesda uses a different term for MissionMenu in the UI files versus Papyrus which uses "BSMissionMenu"

Struct UIMap
	String MySwfName
	{ The name of your swf file without the file extension. }
	Int TargetMenuID = -1 ; -1 = unset
	{ ArmorCraftingMenu = 0,
    BSMissionMenu = 1
    ChargenMenu = 2
    ContainerMenu = 3
    DataMenu = 4
    DrugsCraftingMenu = 5
    FoodCraftingMenu = 6
    GalaxyStarMapMenu = 7
    HUDMessagesMenu = 8
    IndustrialCraftingMenu = 9
    InventoryMenu = 10
    LoadingMenu = 11
    MonocleMenu = 12
    PauseMenu = 13
    SecurityMenu = 14
    ShipCrewMenu = 15
    SkillsMenu = 16
    SpaceshipEditorMenu = 17
    SpaceshipHudMenu = 18
    SpaceshipInfoMenu = 19
    ResearchMenu = 20
    WeaponsCraftingMenu = 21
    WorkshopMenu = 22
	}
	String TargetMenuName
	{ If the menu you are targeting is not listed under TargetMenuID, you can manually enter the name of the menu here without the extension. }
EndStruct

; -------------------------------------
; Editor Properties
; -------------------------------------
Group Config
	UIMap[] Property MyUIMenus Auto Const Mandatory
	{ Define all of your swf file relationships here }
EndGroup



String[] TriggeredMenusThisLoad ; This will prevent spamming UIPlayNice with new registrations constantly

; -------------------------------------
; Events
; -------------------------------------


Event OnQuestStarted()
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
		
	RegisterForMenuEvents()
EndEvent

Event OnMenuOpenCloseEvent(String asMenuName, Bool abOpening)
	OpenLogAndTrace("MyUIPlayNiceManager.OnMenuOpenCloseEvent(" + asMenuName + ", abOpening = " + abOpening + ")")
	if(abOpening)
		int iIndex = TriggeredMenusThisLoad.Find(asMenuName)
		
		if(iIndex < 0 || ! bSendRegistrationEventsOncePerSession)
			TriggerRegistration(asMenuName)
			
			if(TriggeredMenusThisLoad == None || TriggeredMenusThisLoad.Length == 0)
				TriggeredMenusThisLoad = new String[0]
			endif
			
			if TriggeredMenusThisLoad && TriggeredMenusThisLoad.length < 128
				TriggeredMenusThisLoad.Add(asMenuName)
			endif
		endif
	endif
EndEvent

; Make sure it runs again each time the player loads the game
Event Actor.OnPlayerLoadGame(Actor akSender)
	TriggeredMenusThisLoad = new String[0]
	
	RegisterForMenuEvents()
EndEvent

; -------------------------------------
; Functions
; -------------------------------------

Function RegisterForMenuEvents()
	TriggeredMenusThisLoad = new String[0]
	
	String[] MenuNames = GetMenuNamesArray()
	
	int i = 0
	while(i < MyUIMenus.Length)
		String sTargetMenuName = MyUIMenus[i].TargetMenuName
		if(MyUIMenus[i].TargetMenuID >= 0 && MyUIMenus[i].TargetMenuID < MenuNames.Length)
			sTargetMenuName = MenuNames[MyUIMenus[i].TargetMenuID]
		endif
		
		if(sTargetMenuName != "")
			RegisterForMenuOpenCloseEvent(sTargetMenuName)
		endif
		
		i += 1
	endWhile
EndFunction

String[] Function GetMenuNamesArray()
	String[] sMenuNames = new String[0]
	sMenuNames.Add("ArmorCraftingMenu")			; 0
	sMenuNames.Add("BSMissionMenu")				; 1
	sMenuNames.Add("ChargenMenu")				; 2
	sMenuNames.Add("ContainerMenu")				; 3
	sMenuNames.Add("DataMenu")					; 4
	sMenuNames.Add("DrugsCraftingMenu")			; 5
	sMenuNames.Add("FoodCraftingMenu")			; 6
	sMenuNames.Add("GalaxyStarMapMenu") 		; 7
	sMenuNames.Add("HUDMessagesMenu") 			; 8
	sMenuNames.Add("IndustrialCraftingMenu")	; 9
	sMenuNames.Add("InventoryMenu")				; 10	
	sMenuNames.Add("LoadingMenu")				; 11
	sMenuNames.Add("MonocleMenu")				; 12
	sMenuNames.Add("PauseMenu")					; 13
	sMenuNames.Add("SecurityMenu")				; 14
	sMenuNames.Add("ShipCrewMenu")				; 15
	sMenuNames.Add("SkillsMenu")				; 16
	sMenuNames.Add("SpaceshipEditorMenu")		; 17
	sMenuNames.Add("SpaceshipHudMenu")			; 18
	sMenuNames.Add("SpaceshipInfoMenu")			; 19
	sMenuNames.Add("ResearchMenu")				; 20
	sMenuNames.Add("WeaponsCraftingMenu")		; 21	
	sMenuNames.Add("WorkshopMenu")				; 22
	
	return sMenuNames
EndFunction


Function TriggerRegistration(String asMenuName)
	String[] MenuNames = GetMenuNamesArray()
	
	int i = 0
	while(i < MyUIMenus.Length)
		String sTargetMenuName = MyUIMenus[i].TargetMenuName
		
		if(MyUIMenus[i].TargetMenuID >= 0 && MyUIMenus[i].TargetMenuID < MenuNames.Length)
			sTargetMenuName = MenuNames[MyUIMenus[i].TargetMenuID]
		endif
		
		if(sTargetMenuName == asMenuName)
			if(sTargetMenuName == "BSMissionMenu")
				sTargetMenuName = sMissionMenuOverride
			endif
			
			RegisterMenu(MyUIMenus[i].MySwfName, sTargetMenuName)
		endif
		
		i += 1
	endWhile
EndFunction


Function RegisterMenu(String asUserMenuName, String asTargetMenuName)
	String sFullCommand = sRegistrationCommand + sCommandMenuDelimiter + asTargetMenuName + sCommandMenuDelimiter + asUserMenuName
	
	OpenLogAndTrace("Sending watch alert: " + sFullCommand)
	Game.ShowCustomWatchAlert(sFullCommand)
EndFunction

Function OpenLogAndTrace(string sMessage) DebugOnly

	Debug.OpenUserLog(sLogName)
	Debug.traceUser(sLogName, sMessage)

endFunction