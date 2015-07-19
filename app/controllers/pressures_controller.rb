class PressuresController < ApplicationController
  before_action :set_pressure, only: [:show, :edit, :update, :destroy]

  # GET /pressures
  # GET /pressures.json
  def index
    @pressures = Pressure.all
  end

  # GET /pressures/1
  # GET /pressures/1.json
  def show
  end

  # GET /pressures/new
  def new
    @pressure = Pressure.new
  end

  # GET /pressures/1/edit
  def edit
  end

  # POST /pressures
  # POST /pressures.json
  def create
    @pressure = Pressure.new(pressure_params)

    respond_to do |format|
      if @pressure.save
        format.html { redirect_to @pressure, notice: 'Pressure was successfully created.' }
        format.json { render :show, status: :created, location: @pressure }
      else
        format.html { render :new }
        format.json { render json: @pressure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pressures/1
  # PATCH/PUT /pressures/1.json
  def update
    respond_to do |format|
      if @pressure.update(pressure_params)
        format.html { redirect_to @pressure, notice: 'Pressure was successfully updated.' }
        format.json { render :show, status: :ok, location: @pressure }
      else
        format.html { render :edit }
        format.json { render json: @pressure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pressures/1
  # DELETE /pressures/1.json
  def destroy
    @pressure.destroy
    respond_to do |format|
      format.html { redirect_to pressures_url, notice: 'Pressure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pressure
      @pressure = Pressure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pressure_params
      params.require(:pressure).permit(:systolic, :diastolic, :taken_at)
    end
end
