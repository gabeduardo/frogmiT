class CommentsController < ApplicationController
    before_action :set_feature

    def create
      @comment = @feature.comments.new(comment_params)
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
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
