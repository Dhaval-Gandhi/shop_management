class HomesController < ApplicationController

  skip_before_action :authenticate, only: [:login, :create_login, :security]
  http_basic_authenticate_with :name => "admin", :password => "5192", only: [:security] 

  def index
    @setting = Setting.last
  end

  def update_company_details
    @setting = Setting.last
    if @setting.update(setting_params)
      flash[:notice] = "Company details updated"
    else
      flash[:alert] = "Company details not updated"
    end
    redirect_to root_path
  end

  def login
    redirect_to root_path if session[:login_status].present? && session[:login_status] == true
  end

  def create_login
    key = Setting.last.totp_key
    if Otp::Totp.new(key).validate_otp?(params[:otp])
      session[:login_status] = true
      redirect_to root_path
    else
      flash[:alert] = "Wrong OTP"
      redirect_to login_path
    end
  end

  def logout
    session[:login_status] = nil
    redirect_to login_path
  end

  def security
    totp_key = Otp::Totp.new.secret
    Setting.last.update(totp_key: totp_key)
    qrcode = RQRCode::QRCode.new("otpauth://totp/shop_management?secret=#{totp_key}")

    @totp_svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 3,
      standalone: true,
      use_path: true
    )
  end

  private

  def setting_params
    params.require(:setting).permit(:cmp_name, :cmp_address, :cmp_gst)
  end
end
