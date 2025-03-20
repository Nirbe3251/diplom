class UsersController < ApplicationController
  before_action :find_user

  def index; end

  def self.page_head
    'Account'
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
