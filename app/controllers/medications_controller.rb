class MedicationsController < ApplicationController
  before_action :set_medication, only: [:show, :edit, :update, :destroy]

  # GET /medications
  # GET /medications.json
  def index
    @medications = Medication.order("name ASC")
  end

  # GET /medications/1
  # GET /medications/1.json
  def show
  end

  # GET /medications/new
  def new
    @medication = Medication.new
  end

  # GET /medications/1/edit
  def edit
  end

  # POST /medications
  # POST /medications.json
  def create
    @medication = Medication.new(medication_params)

    if @medication.name.present?
      drug_sections = MedlinePlus.find_drug_by_name(@medication.name)
      # we expect drug to be an array of hashes [{title: "Title", body: "Body"}, ...]
      
      if drug_sections != nil
        drug_sections.each do |section|
          if section[:title] == "Why is this medication prescribed?"
            @medication.description = section[:body]
          elsif section[:title] == "What side effects can this medication cause?"
            @medication.side_effects = section[:body]
          end
        end
      end
    end
    
    respond_to do |format|
      if @medication.save
        format.html { redirect_to @medication, notice: 'Medication was successfully created.' }
        format.json { render :show, status: :created, location: @medication }
      else
        format.html { render :new }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medications/1
  # PATCH/PUT /medications/1.json
  def update
    
    if (@medication.description.blank? or @medication.side_effects.blank?) and @medication.name.present?
      drug_sections = MedlinePlus.find_drug_by_name(@medication.name)
      # we expect drug to be an array of hashes [{title: "Title", body: "Body"}, ...]
      
      if drug_sections != nil
        drug_sections.each do |section|
          if section[:title] == "Why is this medication prescribed?"
            @medication.description = section[:body]
          elsif section[:title] == "What side effects can this medication cause?"
            @medication.side_effects = section[:body]
          end
        end
      end
    end

    respond_to do |format|
      if @medication.update(medication_params)
        format.html { redirect_to @medication, notice: 'Medication was successfully updated.' }
        format.json { render :show, status: :ok, location: @medication }
      else
        format.html { render :edit }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medications/1
  # DELETE /medications/1.json
  def destroy
    @medication.destroy
    respond_to do |format|
      format.html { redirect_to medications_url, notice: 'Medication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medication
      @medication = Medication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medication_params
      params.require(:medication).permit(:name, :dose, :frequency)
    end
end
