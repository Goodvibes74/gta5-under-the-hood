# Cookbook: audio

Sounds, ped speech, music and radio in a mod. Part of the [mod-builder's cookbook](README.md).

## Systems it touches

| System | Guide |
| --- | --- |
| Archives, sound sets, banks, scenes | [how audio is organised](/docs/audio/how-audio-is-organised.md) |
| Speech and voices | [speech and dialogue](/docs/audio/speech-and-dialogue.md) |
| Music and radio | [music and radio](/docs/audio/music-and-radio.md) |
| Conversations | [cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) |

## Natives and files

- One-shots: `PLAY_SOUND_FRONTEND(-1, name, set, true)` or `PLAY_SOUND_FROM_ENTITY` / `_FROM_COORD`.
- Loops: `GET_SOUND_ID`, play with the ID, `STOP_SOUND`, `RELEASE_SOUND_ID`.
- Banks: `REQUEST_SCRIPT_AUDIO_BANK` until true; `RELEASE_NAMED_SCRIPT_AUDIO_BANK`.
- Mix: `START_AUDIO_SCENE` / `STOP_AUDIO_SCENE`.
- Speech: `PLAY_PED_AMBIENT_SPEECH_NATIVE` (context), `PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE` (any voice).
- Music: `TRIGGER_MUSIC_EVENT`, radio with `SET_RADIO_TO_STATION_NAME`.
- New audio: `.awc` containers plus `.dat*.rel` config in an add-on pack.

## Traps

- **Loops that never stop** keep playing after the mod ends; always stop and release IDs.
- **A forgotten audio scene** leaves the radio ducked or the world quiet.
- **Music events left running** carry into the next mission.
- **Wrong sound or set name** fails silently; test names with a sandbox first.

## Minimal pattern: a looping alarm

1. Get a sound ID; play the alarm sound from an entity with that ID.
2. Each frame: if the condition is over, stop the sound and release the ID.
3. On cleanup (and on script stop): the same stop and release.

**Quick test:** start the alarm, then stop the mod script; the sound must stop with it.
