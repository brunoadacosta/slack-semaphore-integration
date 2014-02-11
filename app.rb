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

    if payload["branch_name"].nil?
      message = "[Deploy to #{payload["server_name"]}:"
    else
      message = "[#{payload["project_name"]} / #{payload["branch_name"]}]"
    end

    commit = payload["commit"]
    text = "#{message} #{payload["result"].capitalize}: #{commit["message"]} - #{commit["author_name"]}"
    emoji = payload["result"] == "failed" ? ":x:" : ":white_check_mark:"

    body = <<-BODY
      payload={"channel": "#{channel}", "username": "Semaphore", "text": "#{text}", "icon_emoji": "#{emoji}"}
    BODY

    HTTParty.post("https://#{subdomain}.slack.com/services/hooks/incoming-webhook?token=#{token}",
      body: body)
  end
end
