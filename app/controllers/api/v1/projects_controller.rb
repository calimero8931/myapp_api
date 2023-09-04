class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_active_user

  # api/app/services/user_authenticate_service.rb
  # def authenticate_active_user
  #   (current_user.present? && current_user.activated?) || unauthorized_user
  # end

  def index
    projects = []
    date = Date.new(2023,8,31)
    10.times do |n|
      id = n + 1
      name = "#{current_user.name} project #{id.to_s.rjust(2, "0")}"
      updated_at = date + (id * 6).hours
      projects << { id: id, name: name, updatedAt: updated_at }
    end
    # 本来はcurrent_user.projects
    render json: projects
  end
end
