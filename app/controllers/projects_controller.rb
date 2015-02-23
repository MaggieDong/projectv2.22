class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @t0=0
    @t1=0
    @t2=0
    @t3=0
    @t4=0
    @t5=0
    @stories = Story.all
    Story.all.each{|s| @t0+=s.point_value if (s.Stage == 'Analysis' && s.Project_id == @project.id)}
    Story.all.each{|s| @t1+=s.point_value if (s.Stage == 'Ready For Dev' && s.Project_id == @project.id)}
    Story.all.each{|s| @t2+=s.point_value if (s.Stage == 'In Dev' && s.Project_id == @project.id)}
    Story.all.each{|s| @t3+=s.point_value if (s.Stage == 'Dev Complete' && s.Project_id == @project.id)}
    Story.all.each{|s| @t4+=s.point_value if (s.Stage == 'In Test' && s.Project_id == @project.id)}
    Story.all.each{|s| @t5+=s.point_value if (s.Stage == 'Complete' && s.Project_id == @project.id)}
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to admins_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def newstory
    @story = Story.new
    @project = Project.find(params[:id])
  end

  def search
    @project = Project.find(params[:parent_id])
    @stories = Story.all.select { |story| ((story.title =~ /#{params[:q]}/i) ||(story.description =~ /#{params[:q]}/i) ) && (story.Project_id == @project.id)}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description, :developer)
    end
end
