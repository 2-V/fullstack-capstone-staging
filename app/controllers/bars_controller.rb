class BarsController < ApplicationController
  before_action :set_bar, only: [:show, :update, :destroy]


  def index
    @bars = Bar.all

    #render json: @bars
  end


  def show
    #render json: @bar
  end


  def create
    @bar = Bar.new(bar_params)

    if @bar.save
      render :show, status: :created, location: @bar
    else
      render json: @bar.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bars/1
  # PATCH/PUT /bars/1.json
  def update
    @bar = Bar.find(params[:id])

    if @bar.update(bar_params)
      head :no_content
    else
      render json: @bar.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bars/1
  # DELETE /bars/1.json
  def destroy
    @bar.destroy

    head :no_content
  end

  private

    def set_bar
      @bar = Bar.find(params[:id])
    end

    def bar_params
      params.require(:bar).permit(:name)
    end
end
