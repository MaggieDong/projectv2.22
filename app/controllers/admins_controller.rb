class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
    @projects = Project.all
    @developers = Developer.all
    @user = current_user if logged_in?
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
    @admins = Admin.all
    @projects = Project.all
    @developers = Developer.all
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admins_url, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def showstories
    @t0=0
    @t1=0
    @t2=0
    @t3=0
    @t4=0
    @t5=0
    @stories = Story.all
    @project = Project.find(params[:id])
    @developers = Developer.all.select {|s| s.Project_id == @project.id}
    Story.all.each{|s| @t0+=s.point_value if (s.Stage == 'Analysis' && s.Project_id == @project.id)}
    Story.all.each{|s| @t1+=s.point_value if (s.Stage == 'Ready For Dev' && s.Project_id == @project.id)}
    Story.all.each{|s| @t2+=s.point_value if (s.Stage == 'In Dev' && s.Project_id == @project.id)}
    Story.all.each{|s| @t3+=s.point_value if (s.Stage == 'Dev Complete' && s.Project_id == @project.id)}
    Story.all.each{|s| @t4+=s.point_value if (s.Stage == 'In Test' && s.Project_id == @project.id)}
    Story.all.each{|s| @t5+=s.point_value if (s.Stage == 'Complete' && s.Project_id == @project.id)}
    @user = current_user if logged_in?
  end

  def destroyprojects
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:name, :email, :password)
    end
end
