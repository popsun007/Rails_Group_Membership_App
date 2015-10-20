class GroupsController < ApplicationController
  def index
   @groups = Group.all.order(created_at: :desc)
   @user = User.find(session[:user_id])
  end

  def create
    user = User.find(session[:user_id])
    group = user.groups.new(group_param)
    if group.valid?
      group.save
      UserGroup.create(user: user, group: group)
      redirect_to "/groups"
    else
      redirect_to "/groups", flash: { errors: group.errors.full_messages }
    end
  end
  
  def show
    @group = Group.find(params[:id])
    @members_relational_ids = @group.user_groups.all.order(created_at: :desc)
  end

  def update
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to "/groups"
  end

private
  def group_param
    params.require(:group).permit(:name, :description)
  end

end
