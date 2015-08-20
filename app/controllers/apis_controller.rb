class ApisController < ApplicationController
  respond_to :json

  def translations
    @translations = Translation.all
  end
end
