class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy, :sign_up]

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.all
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    @story = Story.find(params[:id])
    @developers = Developer.all.select {|s| s.Story_id == @story.id}
    @user = current_user if logged_in?
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    #@project = Project.find(params[:Project_id])
    #@story = @project.stories.create(story_params)
    #redirect_to project_path(@project)

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sign_up
    @user = current_user
    #@story = Story.find(params[:id])
    @developers = Developer.all.select{|dev| dev.Story_id == params[:id].to_i}
    if @developers.size < 2
      respond_to do |format|
        if @user.update_attributes(:Story_id => params[:id].to_i)
          format.html { redirect_to @story, notice: 'You signed up for this story. Any existing signed up story will be replaced by this story.'}
          format.json { render :show, status: :ok, location: @story }
        else
          format.html { render :show }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    else
      i = rand > 0.5 ? 1 : 0
      respond_to do |format|
        if @developers[i].update_attributes(:Story_id => nil) && @user.update_attributes(:Story_id => params[:id].to_i)
          format.html { redirect_to @story, notice: 'You signed up for this story.Any previous signed up story is replaced by this story.'}
          format.json { render :show, status: :ok, location: @story }
        else
          format.html { render :show }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:Developer_id, :title, :description, :point_value, :Stage, :Developer, :Project_id)
    end
end
