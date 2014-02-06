require 'bundler/setup'
require 'sinatra/base'
require 'json'
require 'httparty'

class SlackSemaphoreIntegration < Sinatra::Application
  post "/" do
    payload = JSON.parse(request.body.read)
    token = params[:token]
    channel = params[:channel]
    subdomain = params[:subdomain]

    commit = payload["commit"]
    text = "[#{payload["project_name"]} / #{payload["branch_name"]}] #{payload["result"].capitalize}: #{commit["message"]} - #{commit["author_name"]}"
    emoji = payload["result"] == "failed" ? ":x:" : ":white_check_mark:"

    body = <<-BODY
      payload={"channel": "#{channel}", "username": "Semaphore", "text": "#{text}", "icon_emoji": "#{emoji}"}
    BODY

    HTTParty.post("https://#{subdomain}.slack.com/services/hooks/incoming-webhook?token=#{token}",
      body: body)
  end
end
