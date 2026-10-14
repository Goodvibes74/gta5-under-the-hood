# Key codes and control IDs

The numbers mods and trainers use for keys and buttons, with TrainerV's `trainerv.ini` as the worked example. Scripts use the same control IDs with `IS_CONTROL_PRESSED` and `DISABLE_CONTROL_ACTION`.

- Keyboard values are Windows virtual-key codes.
- Controller values are GTA V control IDs.
- Xbox, PlayStation 4, and PlayStation 5 labels use the equivalent buttons.
- The controller mapping is the same for PS4 and PS5.

## How to change a binding

Edit the number after `=` in the `[KeyBindings]` section of `trainerv.ini`.
Do not rename the setting or change the `[KeyBindings]` header.

Examples:

```ini
MenuKey=114          ; F3
MenuKeyEnter=101     ; Numpad 5
ControllerEnter=201  ; Xbox A / PS Cross
```

Use `0` to disable a binding. For a two-key action, set both values to the same number if you want a one-key action.

## Keyboard Codes

These are the keyboard codes used by the trainer.

| Key | Code |
|---|---:|
| Left Mouse Button | 1 |
| Right Mouse Button | 2 |
| Middle Mouse Button | 4 |
| Backspace | 8 |
| Tab | 9 |
| Enter / Return | 13 |
| Shift | 16 |
| Ctrl | 17 |
| Alt | 18 |
| Pause | 19 |
| Caps Lock | 20 |
| Escape | 27 |
| Spacebar | 32 |
| Page Up | 33 |
| Page Down | 34 |
| End | 35 |
| Home | 36 |
| Left Arrow | 37 |
| Up Arrow | 38 |
| Right Arrow | 39 |
| Down Arrow | 40 |
| Print Screen | 44 |
| Insert | 45 |
| Delete | 46 |
| 0 | 48 |
| 1 | 49 |
| 2 | 50 |
| 3 | 51 |
| 4 | 52 |
| 5 | 53 |
| 6 | 54 |
| 7 | 55 |
| 8 | 56 |
| 9 | 57 |
| A | 65 |
| B | 66 |
| C | 67 |
| D | 68 |
| E | 69 |
| F | 70 |
| G | 71 |
| H | 72 |
| I | 73 |
| J | 74 |
| K | 75 |
| L | 76 |
| M | 77 |
| N | 78 |
| O | 79 |
| P | 80 |
| Q | 81 |
| R | 82 |
| S | 83 |
| T | 84 |
| U | 85 |
| V | 86 |
| W | 87 |
| X | 88 |
| Y | 89 |
| Z | 90 |
| Numpad 0 | 96 |
| Numpad 1 | 97 |
| Numpad 2 | 98 |
| Numpad 3 | 99 |
| Numpad 4 | 100 |
| Numpad 5 | 101 |
| Numpad 6 | 102 |
| Numpad 7 | 103 |
| Numpad 8 | 104 |
| Numpad 9 | 105 |
| Numpad Multiply | 106 |
| Numpad Add | 107 |
| Numpad Enter | 108 |
| Numpad Subtract | 109 |
| Numpad Decimal | 110 |
| Numpad Divide | 111 |
| F1 | 112 |
| F2 | 113 |
| F3 | 114 |
| F4 | 115 |
| F5 | 116 |
| F6 | 117 |
| F7 | 118 |
| F8 | 119 |
| F9 | 120 |
| F10 | 121 |
| F11 | 122 |
| F12 | 123 |
| Num Lock | 144 |
| Scroll Lock | 145 |
| Left Shift | 160 |
| Right Shift | 161 |
| Left Ctrl | 162 |
| Right Ctrl | 163 |
| Left Alt | 164 |
| Right Alt | 165 |
| Browser Back | 166 |
| Browser Forward | 167 |
| Browser Refresh | 168 |
| Browser Stop | 169 |
| Browser Search | 170 |
| Browser Favorites | 171 |
| Browser Home | 172 |
| Mute | 173 |
| Volume Down | 174 |
| Volume Up | 175 |
| Media Next Track | 176 |
| Media Previous Track | 177 |
| Media Stop | 178 |
| Media Play/Pause | 179 |
| Launch Mail | 180 |
| Semicolon `;` | 186 |
| Equals `=` | 187 |
| Comma `,` | 188 |
| Minus `-` | 189 |
| Period `.` | 190 |
| Slash `/` | 191 |
| Tilde `` ` `` | 192 |
| Left Bracket `[` | 219 |
| Backslash `\` | 220 |
| Right Bracket `]` | 221 |
| Apostrophe `'` | 222 |

## Controller IDs

These are GTA V controller IDs. The names are the standard GTA/FiveM names.

### Xbox and PlayStation button names

| Xbox | PlayStation 4 | PlayStation 5 |
|---|---|---|
| A | Cross / X | Cross / X |
| B | Circle / O | Circle / O |
| X | Square | Square |
| Y | Triangle | Triangle |
| LB | L1 | L1 |
| RB | R1 | R1 |
| LT | L2 | L2 |
| RT | R2 | R2 |
| LS press | L3 press | L3 press |
| RS press | R3 press | R3 press |
| Back | Touchpad | Touchpad |
| Start/Menu | Options | Options |

### Menu and frontend IDs

| ID | GTA control | Xbox | PS4 | PS5 |
|---:|---|---|---|---|
| 187 | `INPUT_FRONTEND_DOWN` | D-pad Down | D-pad Down | D-pad Down |
| 188 | `INPUT_FRONTEND_UP` | D-pad Up | D-pad Up | D-pad Up |
| 189 | `INPUT_FRONTEND_LEFT` | D-pad Left | D-pad Left | D-pad Left |
| 190 | `INPUT_FRONTEND_RIGHT` | D-pad Right | D-pad Right | D-pad Right |
| 191 | `INPUT_FRONTEND_RDOWN` | A | Cross | Cross |
| 192 | `INPUT_FRONTEND_RUP` | Y | Triangle | Triangle |
| 193 | `INPUT_FRONTEND_RLEFT` | X | Square | Square |
| 194 | `INPUT_FRONTEND_RRIGHT` | B | Circle | Circle |
| 195-196 | Frontend left stick axes | Left Stick | Left Stick | Left Stick |
| 197-198 | Frontend right stick axes | Right Stick | Right Stick | Right Stick |
| 199 | `INPUT_FRONTEND_PAUSE` | Start/Menu | Options | Options |
| 200 | `INPUT_FRONTEND_PAUSE_ALTERNATE` | Back/Esc | Back | Touchpad/Options |
| 201 | `INPUT_FRONTEND_ACCEPT` | A | Cross | Cross |
| 202 | `INPUT_FRONTEND_CANCEL` | B | Circle | Circle |
| 203 | `INPUT_FRONTEND_X` | X | Square | Square |
| 204 | `INPUT_FRONTEND_Y` | Y | Triangle | Triangle |
| 205 | `INPUT_FRONTEND_LB` | LB | L1 | L1 |
| 206 | `INPUT_FRONTEND_RB` | RB | R1 | R1 |
| 207 | `INPUT_FRONTEND_LT` | LT | L2 | L2 |
| 208 | `INPUT_FRONTEND_RT` | RT | R2 | R2 |
| 209 | `INPUT_FRONTEND_LS` | LS | L3 | L3 |
| 210 | `INPUT_FRONTEND_RS` | RS | R3 | R3 |
| 211 | `INPUT_FRONTEND_LEADERBOARD` | RB | R1 | R1 |
| 212 | `INPUT_FRONTEND_SOCIAL_CLUB` | Back | Touchpad | Touchpad |
| 213 | `INPUT_FRONTEND_SOCIAL_CLUB_SECONDARY` | RB | R1 | R1 |
| 214 | `INPUT_FRONTEND_DELETE` | X | Square | Square |
| 215 | `INPUT_FRONTEND_ENDSCREEN_ACCEPT` | A | Cross | Cross |
| 216 | `INPUT_FRONTEND_ENDSCREEN_EXPAND` | X | Square | Square |
| 217 | `INPUT_FRONTEND_SELECT` | Back | Touchpad | Touchpad |

### Common gameplay IDs

| ID | GTA control | Xbox | PS4 | PS5 |
|---:|---|---|---|---|
| 21 | `INPUT_SPRINT` | A | Cross | Cross |
| 22 | `INPUT_JUMP` | X | Square | Square |
| 23 | `INPUT_ENTER` | Y | Triangle | Triangle |
| 24 | `INPUT_ATTACK` | RT | R2 | R2 |
| 25 | `INPUT_AIM` | LT | L2 | L2 |
| 28 | `INPUT_SPECIAL_ABILITY` | LS | L3 | L3 |
| 30-35 | `INPUT_MOVE_*` | Left Stick | Left Stick | Left Stick |
| 37 | `INPUT_SELECT_WEAPON` | LB | L1 | L1 |
| 44 | `INPUT_COVER` | RB | R1 | R1 |
| 45 | `INPUT_RELOAD` | B | Circle | Circle |
| 55 | `INPUT_DIVE` | RB | R1 | R1 |
| 58 | `INPUT_THROW_GRENADE` | D-pad Left | D-pad Left | D-pad Left |
| 59-64 | `INPUT_VEH_MOVE_*` | Left Stick | Left Stick | Left Stick |
| 68 | `INPUT_VEH_AIM` | LB | L1 | L1 |
| 69 | `INPUT_VEH_ATTACK` | RB | R1 | R1 |
| 71 | `INPUT_VEH_ACCELERATE` | RT | R2 | R2 |
| 72 | `INPUT_VEH_BRAKE` | LT | L2 | L2 |
| 74 | `INPUT_VEH_HEADLIGHT` | D-pad Right | D-pad Right | D-pad Right |
| 75 | `INPUT_VEH_EXIT` | Y | Triangle | Triangle |
| 76 | `INPUT_VEH_HANDBRAKE` | RB | R1 | R1 |
| 86 | `INPUT_VEH_HORN` | LS | L3 | L3 |

## Important controller note

Controller IDs are action IDs, not universal physical button codes. An ID can behave differently on foot, in a vehicle, in a menu, or in a special mode. For trainer menu bindings, the frontend IDs 187-217 are the most relevant.

The complete GTA V control list is available here:

<https://docs.fivem.net/docs/game-references/controls/>
