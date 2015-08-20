class ProjectsController < ApplicationController
  def new
    @company = Company.find(params[:company_id])
    @project = Project.new
  end

  def create
    @company = Company.find(params[:company_id])
    @project = Project.new(project_params)
    @project.company = @company
    if @project.save
      redirect_to edit_project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @languages = Language.all
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    Language.all.each do |language|
      if params[language.language_key]
        @project.languages << language unless @project.languages.include? language
      else
        @project.languages.delete(language) if @project.languages.include? language
      end
    end
    redirect_to project_path @project
  end

  private

  def project_params
    params.require(:project).permit(:project_name)
  end
end
