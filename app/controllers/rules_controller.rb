class RulesController < ApplicationController
  before_action :set_rule, only: %i[ show edit update destroy ]
  before_action :set_team, only: [:index, :show, :edit, :update, :destroy]

  # GET /rules or /rules.json
  def index
    set_team
    if params[:team_name_id]
      @team = TeamName.find(params[:team_name_id])
      @rules = @team.rules
    else
      @rules = Rule.all
    end
  end

  # GET /rules/1 or /rules/1.json
  def show
  end

  # GET /rules/new
  def new
    @rule = Rule.new
  end

  # GET /rules/1/edit
  def edit
  end

  # POST /rules or /rules.json
  def create
    set_team 
    @rule = @team.rules.new(rule_params)
  
    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: "Rule was successfully created." }
        format.json { render :show, status: :created, location: @rule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /rules/1 or /rules/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to @rule, notice: "Rule was successfully updated." }
        format.json { render :show, status: :ok, location: @rule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1 or /rules/1.json
  def destroy
    @rule.destroy

    respond_to do |format|
      format.html { redirect_to rules_path, status: :see_other, notice: "Rule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    # ユーザーのチームを設定する
    def set_team
      @team = current_user.team_names.find_by(id: params[:team_name_id]) || current_user.team_names.first
      unless @team
        redirect_to rules_path, alert: "チームが見つかりませんでした。"  # チームが見つからない場合の処理
      end
    end

    # Only allow a list of trusted parameters through.
    def rule_params
      params.require(:rule).permit(:title, :details, :background, :created_at, :ended_at)
    end
end