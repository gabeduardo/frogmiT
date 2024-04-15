# Backend Frogmi Gabriel 🐸

Pasos para iniciar el servidor backend

* Clonar este repositorio

*  Realizar un cd a la carpeta raiz del proyecto llamada frogmiT     `cd frogmiT/`
*  La version de ruby utilizada para este backend es `ruby "3.0.0"`, Se debe tener instalado bundler para poder instalar las gemas para este proyecto la version de bundler utilizada es `2.5.7` con `bundle install` las gemas utilizadas  `gem "rails", "~> 7.1.3", ">= 7.1.3.2"` `gem 'httparty'
` `gem 'kaminari', '~> 0.17.0'` `gem 'rack-cors', require: 'rack/cors'` 

* Ejecutar el comando `rails db:migrate`

* Ejecutar la tarea para el llenado de la BD con el comando ` rake fetch_earthquakedata_frogmi:fetch_data`  esto cargara las features 

* iniciar el servidor de rails con `rails s -b 0.0.0.0`

