require 'ostruct'
require 'yaml'

Bundler.require(:default)

module RoleBot
  CONFIG = OpenStruct.new(YAML.load_file('config/config.yml'))

  bot = Discordrb::Bot.new(token: CONFIG.token, client_id: CONFIG.client_id)

  bot.interaction_create do |event|
    user = event.user
    role_id = event.interaction.button.custom_id
    app = event.interaction.button.label

    if user.role?(role_id)
      user.remove_role(role_id)
      Discordrb::LOGGER.info("#{user.distinct}: -#{app}")
      event.respond(content: "You will no longer receive notifications when #{app} is updated.", ephemeral: true)
    else
      user.add_role(role_id)
      Discordrb::LOGGER.info("#{user.distinct}: +#{app}")
      event.respond(content: "You will now receive notifications when #{app} is updated.", ephemeral: true)
    end
  end

  logfile = File.open('log/log.txt', 'a')
  $stderr = logfile
  Discordrb::LOGGER.streams << logfile

  bot.run
end
