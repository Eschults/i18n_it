class ProjectsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @projects = @company.projects
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
    redirect_to project_buckets_path @project
  end
end
