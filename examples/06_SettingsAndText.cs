// Guide: docs/guides/02-SHVDN3-Scripting.md, "Settings files" and "Drawing text".

using GTA;
using GTA.UI;
using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;

namespace Samples
{
	public class SettingsAndText : Script
	{
		private readonly ScriptSettings settings;
		private readonly TextElement speedText = new TextElement("", new PointF(20f, 20f), 0.5f);
		private Keys toggleKey;
		private bool showSpeed;

		public SettingsAndText()
		{
			// scripts\SettingsAndText.ini. The Settings property of Script loads <ScriptFileName>.ini for you;
			// loading by name like this works for any file.
			settings = ScriptSettings.Load(Path.Combine(BaseDirectory, "SettingsAndText.ini"));
			toggleKey = settings.GetValue("Keys", "Toggle", Keys.None);
			showSpeed = settings.GetValue("Display", "ShowSpeed", false);

			Tick += OnTick;
			KeyDown += (sender, e) =>
			{
				if (toggleKey != Keys.None && e.KeyCode == toggleKey)
				{
					showSpeed = !showSpeed;
					settings.SetValue("Display", "ShowSpeed", showSpeed);
					settings.Save(); // writes the ini back to disk
				}
			};
		}

		private void OnTick(object sender, EventArgs e)
		{
			Ped player = Game.Player.Character;
			if (!showSpeed || !player.IsInVehicle())
				return;

			float kmh = player.CurrentVehicle.Speed * 3.6f; // Speed is in metres per second
			speedText.Caption = $"{kmh:0} km/h";
			speedText.Color = kmh > 120f ? Color.Red : Color.White;
			speedText.Draw(); // text has to be drawn every frame
		}
	}
}
