# Starfield UIPlayNice mod

Welcome to the **UIPlayNice** official github.


## What

**UIPlayNice** is a mod I created, and maintain, to help with the main issue Starfield has with UI mods.

## MODS
The following mods work with UIPlayNice:
- [Starfield Compendium](https://creations.bethesda.net/en/starfield/details/2fccc6a3-0368-4b40-bbd4-6a1551d44e41/Starfield_Compendium)
- [Astrolabe](https://creations.bethesda.net/en/starfield/details/8c1a34fb-0ef4-4208-b3cb-a8f2493b1618/Astrolabe)

## Who

I am [Ideki](https://creations.bethesda.net/en/starfield/all?author_displayname=Ideki), author of the following mods for Starfield:
- [Starfield Compendium](https://creations.bethesda.net/en/starfield/details/2fccc6a3-0368-4b40-bbd4-6a1551d44e41/Starfield_Compendium)
- [Starfield Compendium Images](https://creations.bethesda.net/en/starfield/details/a118157d-598b-4c7f-a003-bf982b84eab0/Starfield_Compendium_Images)
- [Astrolabe](https://creations.bethesda.net/en/starfield/details/8c1a34fb-0ef4-4208-b3cb-a8f2493b1618/Astrolabe)

You can contact me on:
- Discord: **_zorglub**
- Reddit: **Zorglub01**

## Why

At the moment the game can only have 1 UI mod modify each of the game menus.

If multiple mods try to modify the same menu, only 1 of them will succeed, forcing players to choose which mod they can have instead of having them all.

I had some changes I wanted to do to some of my mods that would require them to work on the same menu.

After some investigation, I figured that the only way to do so what to create an in-between mod that would handle my mods within the same menu, allowing them to co-exists.

After the initial proof of concept I decided to extend it to multiple menus and make it available to the community.

With **UIPlayNice** we (modders) can focus on making modifying and expanding the game interface without having to worry about modifying/maintaining the game menu UI themselves.

Players do should not have to forced choose between mods simply because the game does not support having multiple modes modifying the same files.

The other goal is to remove the worry of modders to have to maintain their mods for each new version of the game.

**UIPlayNice** takes care of it so modders do not have to modify the game menus files.

## Tools

If you want make UI mods, you will need the following tools:

 - [FFDec](https://github.com/jindrapetrik/jpexs-decompiler): to decompile the game UI menus
 - [Adobe Animate](https://www.adobe.com/ca/products/animate.html): to be able to compile your UI.
 - [Starfield-Creators/Interface: The unofficial Starfield user interface development kit. (github.com)](https://github.com/Starfield-Creators/Interface) by Scrivener07: a very useful repository of all Starfield UI files.
 - Access to the Bethesda Creation Kit.

## How
**UIPlayNice** works by loading UI mods and sharing the events the game menu receives with each mod it handle for that menu.

It also expose the game menu to each UI mod so direct modifications can be done by the mods.

Each UI mod can also add buttons to the game menu buttons bar.

All of this is accomplish simply by implementing the [UIPlayNiceModInterface.as](Example/UIPlayNiceModInterface.as) in your actionscript UI.

I am providing a [sample project](Example) for UI modders to try and start their own project, as well as a [Tutorial](#tutorial) below.

You can also use the sample to start your project, but you have to rename the as/fla files to your own project name. (Remember to change the class names in the fla too!).

Once your project is working properly, contact me so I can add your mod to the list supported mods for UIPlayNice.

**Do NOT include the UIPlayNice.json in your project as the UIPlayNice mod will overwrite yours.**

The proper way is to tell me your mod so I can add it to the UIPlayNice config file in the mod itself.

## Support
I have created a tool that allows me to automatically update the game menu files to support **UIPlayNice** in less than 2 minutes.

So each time a new version of the game will be available, I can publish an updated version of the mod and every mods using **UIPlayNice** should work again.

## Important
As a UI modder using UIPlayNice, remember that you are not the only mod the players are using.

So be mindful of other mods:

- If you modify existing UI elements of a menu, keep the existing path to instances (ex: A menu has element A with a child B, and you want to replace A with your own version. You should still provide a child B in your A in case another mod needs access to it.)

- Refer to the list below of [Menu-Mod-Buttons](#menu-mod-buttons) to see which mod adds which buttons they add.

## Menus
Below is the list of menus **UIPlayNice** supports for modding.
- InventoryMenu
- MissionsMenu
- ArmorCraftingMenu
- DrugCraftingMenu
- FoodCraftingMenu
- IndustrialCraftingMenu
- WeaponCraftingMenu
- Research
- Skills
- ContainerMenu

If you need **UIPlayNice** to support some menus that are not listed above, [contact me](#who) and I will see what can be done.

## Menu Mod Buttons
Below is the list of each menu with the mods and the buttons those mods are using.

Try to not conflict with them.

I know the number of buttons we can use it limited, but let's try our best to not step on each others feet.

- DataMenu
  - Starfield Compendium
	  - Select

## Tutorial

If you are a UI modder interested in using **UIPlayNice**, you need to follow these steps to get it to work:
1. Using Archive2.exe (from the Bethesda Creation Kit), extract **Starfield - Interface.ba2** to a work folder.
2. Go to your work folder and use FFDec to open and extract a menu. Ex: **datamenu.swf**. You need this step to make sure you have the files required to compile later on.
3. Download the **UIPlayNice** mods in your game.
4. Download [UIPlayNice.json](Config/UIPlayNice.json).
Place this file into your **steamapps\common\Starfield\Data\interface** folder,
5. Download all files in [UIPlayNiceExample/Example](Example) and save them in your work folder.
4. Go inside your work folder and open [UIPlayNiceExample.fla](Example/UIPlayNiceExample.fla") with **Adobe Animate**.
5. Publish **UIPlayNiceExample** to generate the swf file.
6. Copy the swf file to **steamapps\common\Starfield\Data\interface**
7. Edit **UIPlayNice.json** and add "UIPlayNiceExample" to any of menuName mods list. ex:
```
 	{
		"menuName": "InventoryMenu",
		"mods": [
			"UIPlayNiceExample"
		]
	}
```
8. Start the game, make sure **UIPlayNice** is enabled in your mod list and open the menu you added **UIPlayNiceExample** to. Ex: Your inventory.
9. You should see some text in red in the top left corner and a dummy button in the bottom right buttons bar.
