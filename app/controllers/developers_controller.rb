class DevelopersController < ApplicationController
  before_action :set_developer, only: [:signup,:show, :edit, :update, :destroy, :passwordchange]

  # GET /developers
  # GET /developers.json
  def index
    @developers = Developer.all
    @project = Project.all
  end

  # GET /developers/1
  # GET /developers/1.json
  def show
 #   @developer =Developer.all
    @project = Project.all.select{|s| s.id == @developer.Project_id }  
    if(@project.length == 0)
      @errors = 1
    else
      @errors = nil
    end  
    @project = nil if (@developer.Project_id == nil)
    @stories = Story.all.select{|s| s.Developer_id == @developer.id}
    @allstories = Story.all.select{|s| s.Project_id == @developer.Project_id}
    @mystories = Story.all.select{|s| s.id == @developer.Story_id}
  end

  # GET /developers/new
  def new
    @developer = Developer.new
  end

  # GET /developers/1/edit
  def edit
  end

  # POST /developers
  # POST /developers.json
  def create
    @developer = Developer.new(developer_params)

    respond_to do |format|
      if @developer.save
        format.html { redirect_to admins_path, notice: 'Developer was successfully created.' }
        format.json { render :show, status: :created, location: @developer }
      else
        format.html { render :new }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  def createstory
    @story = Story.new
    #Story.new.Developer_id = params[:id]
    @developer = Developer.find(params[:id])
    @projects = Project.all
    @projects.each do |f|
      @protitle = f.title if (f.id == @developer.Project_id )
    end
  end

  def signup
    @stories = Story.all.select{|s| s.Project_id == @developer.Project_id}
  end

  # PATCH/PUT /developers/1
  # PATCH/PUT /developers/1.json
  def update
    respond_to do |format|
      if @developer.update(developer_params)
        format.html { redirect_to admins_path, notice: 'Developer was successfully updated.' }
        format.json { render :show, status: :ok, location: @developer }
      else
        format.html { render :edit }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developers/1
  # DELETE /developers/1.json
  def destroy
    @developer.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Developer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
   def passwordchange

   end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_developer
      @developer = Developer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def developer_params
      params.require(:developer).permit(:name, :email, :password, :Project_id, :Story_id)
    end
end
