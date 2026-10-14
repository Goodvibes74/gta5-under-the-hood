// Guide: docs/guides/03-Menus-and-UI.md, "Phone contacts with iFruitAddon2".
// Add a reference to scripts\iFruitAddon2.dll in your .csproj (see Samples.csproj).

using GTA;
using GTA.UI;
using iFruitAddon2;

namespace Samples
{
	public class PhoneContactSample : Script
	{
		private readonly CustomiFruit phone = new CustomiFruit();

		public PhoneContactSample()
		{
			var mechanic = new iFruitContact("Mechanic")
			{
				DialTimeout = 3000,            // ms of ringing before Answered fires
				Active = true,                 // can be called
				Icon = ContactIcon.Lester,
			};
			mechanic.Answered += contact =>
			{
				Notification.PostTicker("The mechanic is on his way.", false);
				phone.Close(2000);             // hang up after 2 s
			};
			phone.Contacts.Add(mechanic);

			// The phone needs updating every frame.
			Tick += (sender, e) => phone.Update();
		}
	}
}
