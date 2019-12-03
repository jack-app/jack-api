class AuthController < ApplicationController
  def login
    if params[:redirect_to]
      redirect_to "https://slack.com/oauth/authorize?client_id=#{ENV["SLACK_CLIENT_ID"]}&scope=users:read,users:read.email&redirect_uri=#{request.protocol}#{request.host_with_port}/api/v1/auth/callback&state=#{params[:redirect_to]}"
    else
      render :plain => "リダイレクト先(redirect_to)が設定されていません"
    end
  end

  def callback
    if params[:code]
      user_id = Slack.oauth_access({client_id: ENV["SLACK_CLIENT_ID"], client_secret: ENV["SLACK_CLIENT_SECRET"], code: params[:code], scope: "users:read,users:read.email"})["user_id"]
      if user_id
        resp = Slack.users_info(:user => user_id)

        puts(resp)

        auth_id = "id"
        auth_token = "token"

        redirect_to "#{params[:state]}?status=ok&auth_id=#{auth_id}&auth_token=#{auth_token}"
      else
        redirect_to "#{params[:state]}?status=error"
      end
    else
      redirect_to "#{params[:state]}?status=error"
    end
  end
end
