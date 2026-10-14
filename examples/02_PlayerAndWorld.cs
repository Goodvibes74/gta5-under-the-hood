// Guide: docs/guides/02-SHVDN3-Scripting.md, "The player, peds, vehicles and the world".

using GTA;
using GTA.Math;
using GTA.UI;
using System.Collections.Generic;

namespace Samples
{
	public static class PlayerAndWorld
	{
		// Everything you spawn stays in the world until you delete it or mark it as no longer needed.
		private static readonly List<Entity> spawned = new List<Entity>();

		public static Vehicle SpawnCarInFront(string modelName)
		{
			Ped player = Game.Player.Character;
			Model model = new Model(modelName);       // "adder", or an add-on such as "urus2018"
			if (!model.IsInCdImage || !model.IsVehicle)
			{
				Notification.PostTicker("Unknown vehicle model: " + modelName, false);
				return null;
			}

			model.Request(1000);                       // load it, waiting up to 1 s
			Vector3 position = player.GetOffsetPosition(new Vector3(0f, 5f, 0f)); // 5 m in front
			Vehicle car = Vehicle.Create(model, position, player.Heading + 90f);
			model.MarkAsNoLongerNeeded();              // the game may unload the model now

			if (car != null)
			{
				car.PlaceOnGround();
				spawned.Add(car);
			}
			return car;
		}

		public static void ArmPlayer()
		{
			Ped player = Game.Player.Character;
			player.Weapons.Give(WeaponHash.CarbineRifle, 250, true, true);
			player.Armor = 100;
			player.Health = player.MaxHealth;
		}

		public static void TeleportToWaypoint()
		{
			if (!Game.IsWaypointActive)
				return;
			Ped player = Game.Player.Character;
			Entity target = player.IsInVehicle() ? (Entity)player.CurrentVehicle : player;
			Vector3 destination = World.WaypointPosition;
			// Ground height is only known once the area has loaded; fall back to a high Z.
			destination.Z = World.GetGroundHeight(destination + new Vector3(0f, 0f, 1000f), out float ground) ? ground + 1f : 500f;
			target.Position = destination;
		}

		public static void CalmNearbyPeds()
		{
			Ped player = Game.Player.Character;
			foreach (Ped ped in World.GetNearbyPeds(player, 30f))
			{
				if (ped.IsAlive && ped != player)
					ped.Task.ClearAllImmediately();
			}
			Game.Player.Wanted.SetWantedLevel(0, false);
			Game.Player.Wanted.ApplyWantedLevelChangeNow(false);
		}

		public static void CleanUp()
		{
			foreach (Entity entity in spawned)
			{
				if (entity.Exists())
					entity.Delete();
			}
			spawned.Clear();
		}
	}
}
