class Api::ProfsController < ApplicationController
  def index
    @profs = Prof.all
    render 'index.json.jb'
  end
end
