Bumbleworks::Api::Application.set_routes do
  scope :module => 'bumbleworks/api' do
    match '/entities', :to => 'entities#types', :methods => [:get]
    match '/entities/:type', :to => 'entities#index', :methods => [:get]
    match '/entities/:type/:id', :to => 'entities#show', :methods => [:get]

    match '/processes', :to => 'processes#index', :methods => [:get]
    match '/processes/:id', :to => 'processes#show', :methods => [:get]

    match '/tasks', :to => 'tasks#index', :methods => [:get]
    match '/tasks/:id', :to => 'tasks#show', :methods => [:get]

    match '/tasks/:id/claim', :to => 'tasks#claim', :methods => [:put]
    match '/tasks/:id/release', :to => 'tasks#claim', :methods => [:put]
    match '/tasks/:id/complete', :to => 'tasks#complete', :methods => [:put]

    match '/trackers', :to => 'trackers#index', :methods => [:get]
    match '/trackers/:id', :to => 'trackers#show', :methods => [:get]

    match '/errors', :to => 'errors#index', :methods => [:get]
    match '/processes/:pid/expressions/:id/error', :to => 'errors#show', :methods => [:get]
    match '/processes/:pid/expressions/:id/error/replay', :to => 'errors#replay', :methods => [:put]

    match '/processes/:pid/expressions/:id', :to => 'expressions#show', :methods => [:get]
    match '/processes/:pid/expressions/:id/cancel', :to => 'expressions#cancel', :methods => [:delete]
    match '/processes/:pid/expressions/:id/kill', :to => 'expressions#kill', :methods => [:delete]

    match '/workers', :to => 'workers#index', :methods => [:get]
    match '/workers/prune', :to => 'workers#prune_stale_worker_info', :methods => [:delete]
    match '/workers/command/:command', :to => 'workers#change_global_state', :methods => [:put]
    match '/workers/:id', :to => 'workers#show', :methods => [:get]
    match '/workers/:id/command/:command', :to => 'workers#change_state', :methods => [:put]
  end
end