Bumbleworks::Api::Application.set_routes do
  scope :module => 'bumbleworks/api' do
    match '/entities', :to => 'entities#types', :methods => [:get]
    match '/entities/:type', :to => 'entities#index', :methods => [:get]
    match '/entities/:type/:id', :to => 'entities#show', :methods => [:get]
  end
end