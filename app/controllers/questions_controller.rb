class QuestionsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_question_user, only: [:edit, :update ,:destroy]  
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end
  
  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "質問「#{@question.question_title}」を投稿しました"
      redirect_to root_path
    else 
      render "new"
    end
  end

  def edit
    @question = Question.find(params[:id])    
  end
  
  def update
    question = Question.find(params[:id])
    if question.update(question_params)
      flash[:success] = "質問「#{question.question_title}」を更新しました"
      redirect_to root_path     
    else
      render "edit"
    end
  end
  
  def destroy
    question = Question.find(params[:id])
    question.destroy
    flash[:danger] = "質問を削除しました"
    redirect_to root_path
  end
  
  private
  
  def question_params
    params.require(:question).permit(:question_title, :question_body)
  end

end
