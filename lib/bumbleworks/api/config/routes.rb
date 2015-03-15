Bumbleworks::Api::Application.set_routes do
  scope :module => 'bumbleworks/api' do
    match '/entities', :to => 'entities#types', :methods => [:get]
    match '/entities/:type', :to => 'entities#index', :methods => [:get]
    match '/entities/:type/:id', :to => 'entities#show', :methods => [:get]

    match '/processes', :to => 'processes#index', :methods => [:get]
    match '/processes/:id', :to => 'processes#show', :methods => [:get]

    match '/tasks', :to => 'tasks#index', :methods => [:get]
    match '/tasks/:id', :to => 'tasks#show', :methods => [:get]
  end
end