class Api::FeaturesController < ApplicationController
    def index
        earthquakes = Feature.all
    
        # Filtro por mag_type (si se proporciona)
        # mag_types = params[:mag_type] ? params[:mag_type] : []
        # para poder verificar si el formato de la url usa filters o directamente mag_types
        mag_types= params.dig(:filters, :mag_type) || params[:mag_type] || []
        earthquakes = earthquakes.where(mag_type: mag_types) if mag_types.present?
    
          # Paginación 
        page = params.dig(:filters, :page) || params[:page] || 1
        per_page = params.dig(:filters, :per_page) || params[:per_page] || 10
        per_page = [per_page.to_i,1000].min
        @paginated_earthquakes = earthquakes.page(page).per(per_page)

        # Serializar los datos para que asi los pueda devolver en el formato especificado
        render json: {
          data: @paginated_earthquakes.map { |earthquake| serialize_earthquake(earthquake) },
          pagination: {
            current_page: @paginated_earthquakes.current_page,
            total: @paginated_earthquakes.total_pages,
            per_page: per_page
          }
         
        }
      end
    
      private
  #   metodo para hacer la serializacion del objeto a rails 
      def serialize_earthquake(earthquake)
        {
          id: earthquake.id,
          type: 'feature',
          attributes: {
            external_id: earthquake.external_id,
            magnitude: earthquake.magnitude,
            place: earthquake.place,
            time: earthquake.time,
            tsunami: earthquake.tsunami,
            mag_type: earthquake.mag_type,
            title: earthquake.title,
            coordinates: {
              longitude: earthquake.longitude,
              latitude: earthquake.latitude
            }
          },
          links: {
            external_url: earthquake.url
          }
        }
      end
end
