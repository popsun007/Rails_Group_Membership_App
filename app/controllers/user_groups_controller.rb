class UserGroupsController < ApplicationController
  
  def create
    group = Group.find(params[:group_id])
    UserGroup.create(user: current_user, group: group)
    redirect_to "/groups/#{group.id}"
  end

  def destroy
    UserGroup.find_by(user_id: params[:id], group_id: params[:group_id]).destroy
    redirect_to "/groups/#{params[:group_id]}"
  end
  
end
