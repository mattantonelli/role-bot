# Role Bot

This is a Discord bot designed to toggle user roles based on button interactions. Powered by [discordrb](https://github.com/shardlab/discordrb).

## Installation

This is currently a private bot. You will need to create and run your own Discord app to add it to your server.

1. [Create a new Discord app](https://discordapp.com/developers/applications/me)
2. Create a bot user
3. Insert your client ID into the following URL: `https://discord.com/oauth2/authorize?&client_id=INSERT_CLIENT_ID_HERE&permissions=268435456&scope=bot`
4. Follow the URL to add the bot to your server (requires the Manage Server permission)
5. `git clone https://github.com/mattantonelli/role-bot`
6. `cd role-bot`
7. `bundle install`
8. Set up the configuration file
    * `cp config/config.yml.example config/config.yml`
9. `bundle exec ruby run.rb`

## Permissions

This bot requires the following permissions:

* Manage Roles

## Setup

Using your bot's token, you will need to send a message containing your desired buttons. The buttons' `custom_id` should correspond with the desired role ID.

```
POST https://discordapp.com/api/channels/12345/messages
```
```json
{
    "content": "To receive a role, please select any of the buttons below:",
    "components": [
        {
            "type": 1,
            "components": [
                {
                    "type": 2,
                    "label": "My Cool Role",
                    "style": 2,
                    "custom_id": "12345"
                }
            ]
        }
    ]
}
```

See the [Discord documentation](https://discord.com/developers/docs/interactions/message-components) for more details.
