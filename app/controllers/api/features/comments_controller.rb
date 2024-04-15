class Api::Features::CommentsController < ApplicationController
 
    skip_before_action :verify_authenticity_token, only: [:create]
    def create
        # Extrae los datos del payload (comment y feature_id)
        comment_params = params.require(:comment).permit(:body, :feature_id)
       
        # Busca el Feature asociado utilizando el feature_id
        feature = Feature.find_by(id: comment_params[:feature_id])
      
        if feature
          # Crea un nuevo comentario y asócialo con el Feature encontrado
          @comment = feature.comments.build(comment_params)
      
          if @comment.save
            render json: { message: 'Comentario creado exitosamente' }, status: :created
          else
            render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: ['No se encontró el Feature con el ID proporcionado'] }, status: :unprocessable_entity
        end
    end
end