# ForeverFriends

World of Warcraft addon that remembers characters and alts discovered through your Battle.net friends.

Whenever a Battle.net friend logs into World of Warcraft with a character you have not seen before, the addon records that character name. Over time, it builds a history of known characters for each Battle.net friend, making it easier to mail items, contact friends, or identify alts when they are offline.

## Goals

- Track character names seen on Battle.net friends
- Build an alt history automatically
- Store data between play sessions
- Provide slash commands to view known characters
- Keep the addon lightweight and simple

## Usage

### Open ForeverFriends

```text
/ff
```

Opens the ForeverFriends window and displays all discovered Battle.net friends along with the characters observed on those accounts.

### Load / Rediscover Characters

```text
/ff load
```

Manually triggers a discovery scan of currently online Battle.net friends. Newly discovered characters are saved to the database.

### Reset Database

```text
/ff reset
```

Clears all stored discoveries and resets the ForeverFriends database.

### Help

```text
/ff help
```

Displays available commands and basic addon information.

## How It Works

ForeverFriends automatically monitors your Battle.net friends and records World of Warcraft characters seen on those accounts.

When a Battle.net friend logs into World of Warcraft using a character you have not encountered before, the addon stores that character information. Over time, this builds a history of known characters and alts for each Battle.net friend.

The addon is intended to make it easier to:

- Find a friend's character names when mailing items
- Identify alts that belong to the same Battle.net account
- Look up previously seen characters even when they are offline
- Build a historical record of characters encountered over time

Only Battle.net friends are tracked. Regular World of Warcraft friends are already available through the in-game Friends List and are therefore not duplicated by the addon.
