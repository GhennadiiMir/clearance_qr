class ClearanceQr < ApplicationController

  def confirm_login
    inquiry_token = params[:t]
    mconto_conf = Rails.application.credentials.mconto
    resp = HTTP.post("#{mconto_conf[:domain]}/api/inquiries/v0/check_login", json: {
      api_token: mconto_conf[:api_token],
      inquiry_token: inquiry_token
    })
    resp_data = JSON.parse(resp.body).with_indifferent_access rescue {}

    if resp_data[:success]
      user = User.find_by(email: resp_data[:email])
      if user.nil?
        user = User.create(email: resp_data[:email], password: SecureRandom.uuid)
      end

      sign_in user
      redirect_to Clearance.configuration.redirect_url, notice: "You signed in successfully as #{user.email}"
    else
      redirect_to sing_in_url, alert: "Login unsuccessful"
    end
  end


end
