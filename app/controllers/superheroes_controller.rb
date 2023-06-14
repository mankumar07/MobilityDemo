class SuperheroesController < ApplicationController
  before_action :set_superhero, only: %i[ show edit update destroy ]

  def index
    @superheroes = if params[:name_q]
      Superhero.search params[:name_q]
    else
      Superhero.all
    end
  end
  
  def show
  end

  def new
    @superhero = Superhero.new
  end

  def edit
  end

  def create
    @superhero = Superhero.new(superhero_params)
    if @superhero.save
      redirect_to @superhero, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @superhero.update(superhero_params)
      redirect_to @superhero, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @superhero.destroy
    redirect_to superheroes_url, notice: t('.success')
  end

  private
    def set_superhero
      @superhero = Superhero.find(params[:id])
    end

    def superhero_params
      params.require(:superhero).permit(I18n.available_locales.map do |l|
        [:"name_#{Mobility.normalize_locale(l)}", :"description_#{Mobility.normalize_locale(l)}"]
      end.flatten)
    end
end
