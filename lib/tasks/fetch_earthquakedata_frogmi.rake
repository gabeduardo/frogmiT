namespace :fetch_earthquakedata_frogmi do
    desc 'Fetch earthquake data from USGS GeoJSON feed and persist in database'
    task fetch_data: :environment do
      url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
      response = HTTParty.get(url)
  
      if response.code == 200
        data = JSON.parse(response.body)['features']
  
        data.each do |feature|
          properties = feature['properties']
          coordinates = feature['geometry']['coordinates']
  
          next if properties['title'].nil? || properties['url'].nil? || properties['place'].nil?
  
          # Validar rangos
          next unless (-1.0..10.0).cover?(properties['mag'])
          next unless (-90.0..90.0).cover?(coordinates[1])
          next unless (-180.0..180.0).cover?(coordinates[0])
          
          # para asegurarme de que es un atributo unico 
          earthquake = Feature.find_or_initialize_by(external_id:feature['id'])


          if earthquake.new_record?
            earthquake.update(
              magnitude: properties['mag'],
              place: properties['place'],
              time: properties['time'],
              url: properties['url'],
              tsunami: properties['tsunami'],
              mag_type: properties['magType'],
              title: properties['title'],
              longitude: coordinates[0],
              latitude: coordinates[1]
            )
          end
 
          
        end
      else
        puts 'Error fetching data from USGS.'
      end
    end
end
