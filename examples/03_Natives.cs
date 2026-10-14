// Guide: docs/guides/05-Natives.md, "Calling natives from C#".
// Use a native when SHVDN has no property or method for what you need.

using GTA;
using GTA.Math;
using GTA.Native;

namespace Samples
{
	public static class NativeCalls
	{
		public static void Examples()
		{
			Ped player = Game.Player.Character;

			// No return value: Function.Call(Hash.NAME, arguments...).
			// SHVDN converts Ped, Vehicle, Entity, Vector3 parts, bool, int, float and string arguments for you.
			Function.Call(Hash.SET_PED_CAN_RAGDOLL, player, false);

			// With a return value: Function.Call<T>.
			bool isSwimming = Function.Call<bool>(Hash.IS_PED_SWIMMING, player);
			int gameTimer = Function.Call<int>(Hash.GET_GAME_TIMER);
			Vector3 coords = Function.Call<Vector3>(Hash.GET_ENTITY_COORDS, player, true);

			// A native with an output parameter (int*, float*, Vector3* in NativeDB): use OutputArgument.
			using (var groundZ = new OutputArgument())
			{
				bool found = Function.Call<bool>(Hash.GET_GROUND_Z_FOR_3D_COORD, coords.X, coords.Y, coords.Z + 100f, groundZ, false, false);
				if (found)
					coords.Z = groundZ.GetResult<float>();
			}

			// A native that isn't in the Hash enum (too new, or unnamed): cast its 64-bit hash.
			// The hash is shown next to each native in docs/reference/natives/.
			Function.Call((Hash)0xD80958FC74E988A6); // PLAYER_PED_ID, just as an example

			_ = isSwimming;
			_ = gameTimer;
		}
	}
}
