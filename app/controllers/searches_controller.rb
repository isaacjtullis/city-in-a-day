class SearchesController < ApplicationController
  # def index
  #   @search = nil
  #   if params[:search] == ""
  #     @search = nil
  #   elsif !params[:search].nil? && params[:search] != ""
  #     if Trail.search(params[:search]).empty?
  #       @error = 'Sorry, we cannot find what you are looking for'
  #     else
  #       @search = Trail.search(params[:search])
  #     end
  #   end
  # end
  def index
    if params[:search] == ""
      @trails = nil
    elsif !params[:search].nil? && params[:search] != ""
      if Trail.search(params[:search]).empty?
        @error = 'Sorry, we cannot find what you are looking for'
      else
        @trails = Trail.search(params[:search])
      end
    end
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.create!(params[:search])
    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
  end

  private

  def search_params
    params.require(:search).permit( :params)
  end
end
