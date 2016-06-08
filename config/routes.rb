Broker::Engine.routes.draw do
  get    'bbb/recordings/(:id.:format)',  :to => 'bbb#recording_list',    :as => :bbb_recordings, :defaults => {format: :json}
  get    'bbb/recording/(:id.:format)',   :to => 'bbb#recording',         :as => :bbb_recording
  patch  'bbb/recording/(:id.:format)',   :to => 'bbb#recording_publish', :as => :bbb_recording_publish
  delete 'bbb/recording/(:id.:format)',   :to => 'bbb#recording_delete',  :as => :bbb_recording_delete

  root :to => "bbb#index"
end
