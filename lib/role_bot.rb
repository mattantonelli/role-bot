require 'ostruct'
require 'yaml'

Bundler.require(:default)

module RoleBot
  CONFIG = OpenStruct.new(YAML.load_file('config/config.yml'))

  bot = Discordrb::Bot.new(token: CONFIG.token, client_id: CONFIG.client_id, log_mode: :quiet)

  bot.interaction_create do |event|
    user = event.user
    role_id = event.interaction.button['custom_id'].to_i
    app = event.interaction.button['label']

    if user.roles.map(&:id).include?(role_id)
      user.remove_role(role_id)
      event.respond(content: "You will no longer receive notifications when #{app} is updated.", ephemeral: true)
    else
      user.add_role(role_id)
      event.respond(content: "You will now receive notifications when #{app} is updated.", ephemeral: true)
    end
  end

  bot.run
end