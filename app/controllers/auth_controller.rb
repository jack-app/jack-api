require 'bcrypt'
require 'securerandom'

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

      # OAuthのリダイレクト先がlocalhost:3000だとリダイレクト拒否されるため，SLACK_USER_ID_FOR_LOCALHOSTを利用してログインする
      if request.host == "localhost"
        user_id = ENV["SLACK_USER_ID_FOR_LOCALHOST"]
      else
        resp = Slack.oauth_access({client_id: ENV["SLACK_CLIENT_ID"], client_secret: ENV["SLACK_CLIENT_SECRET"], code: params[:code], scope: "users:read,users:read.email"})
        user_id = resp["user_id"]
      end

      if user_id
        resp = Slack.users_info(:user => user_id)

        puts(resp)

        user = User.find_by(slack_id: resp['user']['id'])
        if user.nil?
          user = User.new(
                  slack_id: resp['user']['id'],
                  nickname: resp['user']['profile']['display_name'],
                  email: resp['user']['profile']['email']
          )

          if resp['user']['real_name'].split(/\s/)[1]
            first_name = resp['user']['real_name'].split(/\s/)[1];
            last_name = resp['user']['real_name'].split(/\s/)[0];
          else
            first_name = resp['user']['real_name'].substr(2);
            last_name = resp['user']['real_name'].substr(0, 2);
          end
          user.first_name = first_name
          user.last_name = last_name
        end

        user.slack_image = resp['user']['profile']['image_original']

        auth_token = SecureRandom.urlsafe_base64(32)

        user.auth_token = BCrypt::Password.create(auth_token)

        user.save()

        redirect_to "#{params[:state]}?status=ok&auth_id=#{user.id}&auth_token=#{auth_token}"
      else
        redirect_to "#{params[:state]}?status=error"
      end
    else
      redirect_to "#{params[:state]}?status=error"
    end
  end
end
