class SideEffectsController < ApplicationController
  before_action :set_side_effect, only: [:show, :edit, :update, :destroy]

  # GET /side_effects
  # GET /side_effects.json
  def index
    @side_effects = SideEffect.all
  end

  # GET /side_effects/1
  # GET /side_effects/1.json
  def show
  end

  # GET /side_effects/new
  def new
    @side_effect = SideEffect.new
  end

  # GET /side_effects/1/edit
  def edit
  end

  # POST /side_effects
  # POST /side_effects.json
  def create
    @side_effect = SideEffect.new(side_effect_params)

    respond_to do |format|
      if @side_effect.save
        format.html { redirect_to @side_effect, notice: 'Side effect was successfully created.' }
        format.json { render :show, status: :created, location: @side_effect }
      else
        format.html { render :new }
        format.json { render json: @side_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /side_effects/1
  # PATCH/PUT /side_effects/1.json
  def update
    respond_to do |format|
      if @side_effect.update(side_effect_params)
        format.html { redirect_to @side_effect, notice: 'Side effect was successfully updated.' }
        format.json { render :show, status: :ok, location: @side_effect }
      else
        format.html { render :edit }
        format.json { render json: @side_effect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /side_effects/1
  # DELETE /side_effects/1.json
  def destroy
    @side_effect.destroy
    respond_to do |format|
      format.html { redirect_to side_effects_url, notice: 'Side effect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_side_effect
      @side_effect = SideEffect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def side_effect_params
      params.require(:side_effect).permit(:drug_id, :symptom_id)
    end
end
