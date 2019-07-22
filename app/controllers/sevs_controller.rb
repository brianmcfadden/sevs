class SevsController < ApplicationController
  def index
    @side_effects = SideEffect.all
    @drugs = Drug.all
    @symptoms = Symptom.all
  end

  def create
    respond_to do |format|
      Rails.logger.level = 0
      # params.each do |key,value|
        # Rails.logger.warn "Param #{key}: #{value}"
      # end

      @symptom = Symptom.find(params[:symptom][:id])

      # for each drug, go through side effects for that drug
      # and match the symptom - add to side effects list
      # and pass that on to the view
      @drugs = []
      @sideEffects = []
      @drugList = params[:drugList]
      if @drugList != nil
        @drugList.each do |drugId|
          @drug = Drug.find(drugId)
          Rails.logger.warn "Checking drug #{@drug.name}"
          @drugs.push(@drug)
          @sideEffectsList = SideEffect.where(drug_id: drugId)
          @sideEffectsList.each do |se|
            if se.symptom_id == @symptom.id
              Rails.logger.warn "Matched #{@symptom.name} with #{@drug.name}"
              @sideEffects.push(se)
            end # if symptom_id
          end # each SideEffect
        end # each drugList
        format.html {
          render "generate_report"
        }
      else # if @drugList == nil
        format.html { redirect_to("/404.html") }
      end # if @drugList
      format.all  { redirect_to("/404.html") }
    end # respond_to
  end # def create
end
