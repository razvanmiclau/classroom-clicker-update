class AnswersController < ApplicationController
  before_action :set_question, :set_question_answers
  respond_to :html, :js
  layout :custom_layout

  def custom_layout
    if current_or_guest_user == guest_user
      "student-layout"
    else
      "application"
    end
  end

  def index
    @answers = @responds.order('created_at desc')
    @answer = @responds.build
    impressionist(@question, 'visited')
  end

  def new
    @answer = @responds.build
  end

  def create
    @answers = @responds.order('created_at desc')
    @answer = @responds.build(answer_params)
    respond_to do |format|
        if @answer.save
          format.html {redirect_to topic_question_answers_path, notice: 'Success'}
          format.js {}
          format.json { render json: @answer, status: :created, location: @answer}
        else
          redirect_to topic_question_answers_path, notice: 'Fail'
          format.json { render json: @answer.errors, status: :unprocessable_entity}
        end
      end
  end

  def data
    @data = @responds.all
    @total = Question.where(:uuid => params[:question_id]).first.answers.group(:value).count
    dataArray = Array.new
      @data.each do |key|
        dataArray.push(key['value'].split()) #[[1,2,3],[4,5,6]]
      end
    @wordsArray = dataArray.flatten #[1,2,3,4,5,6]
    render :json => {:answers => @data, :total => @total, :words => @wordsArray}
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_question_answers
      @responds = @question.answers
    end

    def answer_params
      params.require(:answer).permit(:value, :question_id)
    end
end
