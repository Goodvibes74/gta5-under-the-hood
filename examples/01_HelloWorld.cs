// Guide: docs/guides/02-SHVDN3-Scripting.md, "Your first script".
// The smallest useful script: runs code every frame and reacts to a key.

using GTA;
using GTA.UI;
using System;
using System.Windows.Forms;
// System.Windows.Forms also has a Screen class. This alias says which one "Screen" means.
using Screen = GTA.UI.Screen;

namespace Samples
{
	public class HelloWorld : Script
	{
		public HelloWorld()
		{
			// Runs once, when SHVDN loads the script (game start, or Reload() in the F4 console).
			Tick += OnTick;       // every frame
			KeyDown += OnKeyDown; // every key press
			Aborted += OnAborted; // when the script stops: clean up what you created
			Interval = 0;         // ms between Tick calls; 0 means every frame
		}

		private void OnTick(object sender, EventArgs e)
		{
			// Keep this fast: the game waits for it every frame.
			if (Game.Player.Character.IsInVehicle())
				Screen.ShowSubtitle("You're driving", 100);
		}

		private void OnKeyDown(object sender, KeyEventArgs e)
		{
			if (e.KeyCode == Keys.Pause) // pick a key no other mod uses
				Notification.PostTicker("Hello from SHVDN v3", false);
		}

		private void OnAborted(object sender, EventArgs e)
		{
		}
	}
}
