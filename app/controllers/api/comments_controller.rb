class  Api::CommentsController < ApplicationController
  before_action :set_feature
  skip_before_action :verify_authenticity_token, only: [:create]
  def create
    @comment = @feature.comments.new(comment_params)
      if @comment.body.present?
        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      
      else
        render json: { error: "El campo body no puede estar vacío"},status: :unprocessable_entity
      
      end
  end
  private

  def set_feature
    @feature = Feature.find(params[:feature_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
