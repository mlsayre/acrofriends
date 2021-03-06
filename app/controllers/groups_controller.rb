class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def memberauthorize
    unless @group.users.ids.include?(current_user.id)
      redirect_to groups_path
      flash[:notice] = "Sorry, you are not a member of that private group."
    end
  end

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    @memberships = Membership.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    memberauthorize

    if @group.private == true
      @topbarimage = "Lock-128.png"
    end
    @memberships = Membership.all

    # chat
    @chat = Chat.where('group_id = ?', @group.id)
  end

  def showmembers
    @group = Group.find(params[:id])

    memberauthorize

    if @group.private == true
      @privatestatus = "(Private group)"
      @topbarimage = "Lock-128.png"
    elsif @group.private == false
      @privatestatus = "(Open group)"
    end
    @memberships = Membership.all
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    memberauthorize
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        Membership.create(:user_id => current_user.id, :group_id => Group.last.id)
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    memberauthorize

    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    # @group.destroy
    # respond_to do |format|
    #   format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :password, :private)
    end
end
