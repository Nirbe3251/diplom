class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def index
    render json: { message: 'Welcome!' }, status: :ok
  end
end
