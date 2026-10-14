// Guide: docs/guides/03-Menus-and-UI.md, "Building a menu with LemonUI".

using GTA;
using GTA.UI;
using LemonUI;
using LemonUI.Menus;
using System;
using System.Windows.Forms;

namespace Samples
{
	public class LemonMenuSample : Script
	{
		// 1. One pool holds every menu. Process() it every frame, or nothing draws.
		private readonly ObjectPool pool = new ObjectPool();

		// 2. The main menu: banner title, subtitle.
		private readonly NativeMenu menu = new NativeMenu("My Mod", "Main menu");

		// A submenu is just another NativeMenu.
		private readonly NativeMenu vehicleMenu = new NativeMenu("My Mod", "Vehicles");

		public LemonMenuSample()
		{
			pool.Add(menu);
			pool.Add(vehicleMenu); // submenus must be in the pool too

			// 3. Items. Each has a title and an optional description shown under the menu.

			// A plain button: Activated fires when you press Enter / A / Cross on it.
			var heal = new NativeItem("Heal", "Restores health and armor.");
			heal.Activated += (sender, e) =>
			{
				Game.Player.Character.Health = Game.Player.Character.MaxHealth;
				Game.Player.Character.Armor = 100;
			};
			menu.Add(heal);

			// A checkbox: CheckboxChanged fires when it flips. Read .Checked.
			var neverWanted = new NativeCheckboxItem("Never wanted", "Keeps your wanted level at 0.", false);
			menu.Add(neverWanted);

			// A list: left/right picks a value. ItemChanged fires on every change.
			var weather = new NativeListItem<Weather>("Weather", "Changes the weather.", Weather.Clear, Weather.Raining, Weather.Foggy, Weather.Snowing);
			weather.ItemChanged += (sender, e) => World.Weather = e.Object;
			menu.Add(weather);

			// A slider: 0 to Maximum. ValueChanged fires on every change.
			var wanted = new NativeSliderItem("Wanted level", "Sets the wanted level.", 5, 0);
			wanted.ValueChanged += (sender, e) =>
			{
				Game.Player.Wanted.SetWantedLevel(wanted.Value, false);
				Game.Player.Wanted.ApplyWantedLevelChangeNow(false);
			};
			menu.Add(wanted);

			// A separator line between groups of items.
			menu.Add(new NativeSeparatorItem("Vehicles"));

			// A submenu entry. AddSubMenu returns the item, so you can set its description.
			NativeSubmenuItem vehiclesItem = menu.AddSubMenu(vehicleMenu);
			vehiclesItem.Description = "Spawn vehicles.";

			var adder = new NativeItem("Spawn Adder");
			adder.Activated += (sender, e) => PlayerAndWorld.SpawnCarInFront("adder");
			vehicleMenu.Add(adder);

			// Menu events.
			menu.Shown += (sender, e) => Notification.PostTicker("Menu opened", false);

			Tick += (sender, e) =>
			{
				pool.Process(); // draws visible menus and handles their input

				if (neverWanted.Checked && Game.Player.Wanted.WantedLevel > 0)
				{
					Game.Player.Wanted.SetWantedLevel(0, false);
					Game.Player.Wanted.ApplyWantedLevelChangeNow(false);
				}
			};

			KeyDown += (sender, e) =>
			{
				// 4. Open and close with a key. Pick one no other mod uses.
				if (e.KeyCode == Keys.Pause)
					menu.Visible = !menu.Visible;
			};
		}
	}
}
