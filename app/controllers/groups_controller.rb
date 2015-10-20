class GroupsController < ApplicationController
  before_action :require_login, only: [:show, :create, :destroy]

  def index
   @groups = Group.all.order(created_at: :desc)
    if session[:user_id] == nil
      redirect_to "/sessions/new"
    else
      @user = User.find(session[:user_id])
    end
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
    @members = @group.usersJoined
    
    #another way to show all members in a group:
    # @members_relational_ids = @group.user_groups.all.order(created_at: :desc)

    # in /view/groups/show.html.erb page :
    # <% @members_relational_ids.each do |r| %>
    #    <% user = User.find(r.user_id) %>
    #    <p><%= user.first_name + " " + user.last_name %></p>
    # <% end %>

  end

  def update
  end

  def destroy
    group = Group.find(params[:id])
    if group.user == User.find(session[:user_id])
      group.destroy
    end
    redirect_to "/groups"
  end

private
  def group_param
    params.require(:group).permit(:name, :description)
  end

end
