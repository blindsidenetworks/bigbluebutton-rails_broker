Broker::Engine.routes.draw do
  get    'bbb/recordings(.:format)',      :to => 'bbb#recordings',    :as => :bbb_recordings_all, :defaults => {:format => :json}
  get    'bbb/recordings/:id(.:format)',  :to => 'bbb#recordings',    :as => :bbb_recordings,     :defaults => {:format => :json}
  get    'bbb/recording/:id(.:format)',   :to => 'bbb#recording',     :as => :bbb_recording,  :defaults => {:format => :json}
  patch  'bbb/recording/:id(.:format)',   :to => 'bbb#recording_update',  :as => :bbb_recording_update,  :defaults => {:format => :json}
  delete 'bbb/recording/:id(.:format)',   :to => 'bbb#recording_delete',  :as => :bbb_recording_delete,  :defaults => {:format => :json}
  get    'bbb/recording/update/:id(.:format)',   :to => 'bbb#recording_update',  :as => :bbb_recording_update_get,  :defaults => {:format => :json}
  get    'bbb/recording/delete/:id(.:format)',   :to => 'bbb#recording_delete',  :as => :bbb_recording_delete_get,  :defaults => {:format => :json}

  root :to => "bbb#index"
end
