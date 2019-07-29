class SevsController < ApplicationController
  def index
    @side_effects = SideEffect.all
    @drugs = Drug.all
    @symptoms = Symptom.all
  end

  def create
    @title = "Report"
    respond_to do |format|
      Rails.logger.level = 0

      @symptom = Symptom.find(params[:symptom][:id])

      # for each drug, go through side effects for that drug
      # and match the symptom - add to side effects list
      # and pass that on to the view
      @drugs = []
      @sideEffects = []
      @commonSideEffects = []
      @drugList = params[:drugList]
      if @drugList != nil
        @drugList.each do |drugId|
          @drug = Drug.find(drugId)
          @drugs.push(@drug)
          @sideEffectsList = SideEffect.where(drug_id: drugId)
          @sideEffectsList.each do |se|
            #
            @cse = @commonSideEffects.find { |cse| cse[:side].symptom_id == se.symptom_id }
            if @cse != nil
              @cse[:count] += 1
            else
              @commonSideEffects.push( { :side  => se, :count => 1} )
            end
            #
            if se.symptom_id == @symptom.id
              @sideEffects.push(se)
            end # if symptom_id
          end # each SideEffect
        end # each drugList
        # top ten-ish common side effects
        @commonSideEffects = @commonSideEffects.sort_by { |cse| -cse[:count] }
        @commonSideEffects.keep_if { |c| c[:count] > 1 }
        if @commonSideEffects.length >= 10  then
          t = @commonSideEffects[10][:count]
          @commonSideEffects.keep_if { |c| c[:count] >= t }
        end
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
