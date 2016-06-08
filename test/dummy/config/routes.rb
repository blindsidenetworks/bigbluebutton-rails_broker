Rails.application.routes.draw do

  mount Broker::Engine => "/"
end
